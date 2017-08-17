#!/usr/bin/env python2
"""
Simple script to import valid former exported XML configuration (e.g templates)
to a specified Zabbix-server.
"""
import argparse
import subprocess as sub
import urllib2
import os.path

try:
    import json
except ImportError:
    import simplejson as json

__author__ = 'pku'


def zbx_auth(zbxurl, username='Admin', password='zabbix'):
    """
    Returns a valid Zabbix authtoken for given username and
    password on the server running at zbxurl. Quits otherwise
    because the other methods depend on a valid token.

    :param zbxurl: full URL to zabbix-server api
    :param username: username to be authed for
    :param password: password for username
    :return: zabbix auth token
    """
    values = {'jsonrpc': '2.0',
              'method': 'user.login',
              'params': {
                  'user': username,
                  'password': password
              },
              'id': '0'}

    data = json.dumps(values)
    req = urllib2.Request(zbxurl, data,
                          {'Content-Type': 'application/json-rpc'})
    response = urllib2.urlopen(req, data)
    output = json.loads(response.read())

    if 'result' in output:
        return output['result']
    else:
        print output['error']['data']
        quit()


def zbx_set_items_to_active(url, authid, templates=None):
    """
    Sets the type of all items in the template to "zabbix (active)"

    :param url: URL to zabbix-server api
    :param authid:  valid auth-token
    :param templates: name of the to be changed templates
    """
    if templates is None:
        templates = ['Template OS Linux']

    values = {'jsonrpc': '2.0',
              'method': 'template.get',
              'params': {
                  'output': 'extend',
                  'filter': {
                      'host': templates
                  }
              },
              'auth': authid,
              'id': 1}
    data = json.dumps(values)
    req = urllib2.Request(url, data,
                          {'Content-Type': 'application/json-rpc'})
    response = urllib2.urlopen(req, data)
    output = json.loads(response.read())

    templateids = []
    for answer in output['result']:
        templateids.append(answer['templateid'])

    values = {'jsonrpc': '2.0',
              'method': 'item.get',
              'params': {
                  'output': 'extend',
                  'templateids': templateids,
              },
              'auth': authid,
              'id': 1}
    data = json.dumps(values)
    req = urllib2.Request(url, data,
                          {'Content-Type': 'application/json-rpc'})
    response = urllib2.urlopen(req, data)
    output = json.loads(response.read())

    itemids = []
    for item in output['result']:
        itemids.append(item['itemid'])

    for itemid in itemids:
        values = {'jsonrpc': '2.0',
                  'method': 'item.update',
                  'params': {
                      'itemid': itemid,
                      'type': '7',
                  },
                  'auth': authid,
                  'id': 1}
        data = json.dumps(values)
        req = urllib2.Request(url, data,
                              {'Content-Type': 'application/json-rpc'})
        response = urllib2.urlopen(req, data)
        output = json.loads(response.read())
    print 'Success: updated item types to "zabbix (active)"'


def zbx_add_autoregistration(url, authid, templates=None):
    """
    Creates a autoregistation action which adds incoming hosts and
    links them to the specified templates.

    :param url: URL to zabbix-server api
    :param authid: valid auth-token
    :param templates: to be added templates
    """
    if templates is None:
        templates = ['Template OS Linux']

    values = {'jsonrpc': '2.0',
              'method': 'template.get',
              'params': {
                  'output': 'extend',
                  'filter': {
                      'host': templates
                  }
              },
              'auth': authid,
              'id': 1}
    data = json.dumps(values)
    req = urllib2.Request(url, data,
                          {'Content-Type': 'application/json-rpc'})
    response = urllib2.urlopen(req, data)
    output = json.loads(response.read())

    templateids = []
    for answer in output['result']:
        templateids.append(answer['templateid'])

    values = {'jsonrpc': '2.0',
              'method': 'action.create',
              'params': {
                  'name': 'Add all incoming hosts and link templates',
                  'eventsource': 2,
                  'status': 0,
                  'esc_period': 0,
                  'operations': [
                      {
                          'esc_step_from': 1,
                          'esc_period': 0,
                          # add to monitored hosts
                          'operationtype': 2,
                          'esc_step_to': 1
                      },
                      {
                          'esc_step_from': 1,
                          'esc_period': 0,
                          # link to template of id
                          'operationtype': 6,
                          'optemplate': [
                              {
                                  'templateid': templateid
                              } for templateid in templateids
                          ],
                          'esc_step_to': 1
                      }
                  ]
              },
              'auth': authid,
              'id': 1}

    data = json.dumps(values)
    req = urllib2.Request(url, data,
                          {'Content-Type': 'application/json-rpc'})
    response = urllib2.urlopen(req, data)
    output = json.loads(response.read())

    if 'result' in output:
        print 'Success: added autoregistration!'
    else:
        print 'Error: ' + output['error']['data']
        quit()


def zbx_import(filenames, url, authid):
    """
    Tries to import all given template files.

    TODO: return template names of added templates

    :param filenames: paths to exported zabbix configuration
    :param url: full URL to zabbix-server api
    :param authid: valid zabbix auth token
    :return: True on success, False on failure
    """
    for filename in filenames:
        proc = sub.Popen(['/usr/bin/env', 'file', filename],
                         stdout=sub.PIPE, stderr=sub.PIPE)
        output, _ = proc.communicate()

        if 'XML document text' in output:
            with open(filename, 'rb') as xmlfile:
                values = {'jsonrpc': '2.0',
                          'method': 'configuration.import',
                          'params': {
                              'format': 'xml',
                              'rules': {
                                  'groups': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  },
                                  'hosts': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  },
                                  'templates': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  },
                                  'triggers': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  },
                                  'items': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  },
                                  'applications': {
                                      'createMissing': True,
                                      'updateExisting': True
                                  }
                              },
                              'source': xmlfile.read()
                          },
                          'auth': authid,
                          'id': 2}
            data = json.dumps(values)
            req = urllib2.Request(url, data,
                                  {'Content-Type': 'application/json-rpc'})
            response = urllib2.urlopen(req, data)
            output = json.loads(response.read())

            if 'result' in output:
                print 'Success: imported ' + filename
                return output['result']
            else:
                print 'Error: ' + output['error']['data']
                return False
        else:
            print 'Error: ' + filename + ' is not a valid XML document!'


def zbx_add_notifyscript(sname, url, authid):
    """
    Adds the passed script name as new media type
    TODO: implement this
    :param sname: name of script, has to be in /usr/lib/zabbix/alertscripts
    :return: True on success, False on failure
    """
    if os.path.isfile('/usr/lib/zabbix/alertscripts/' + sname):
        values = {'jsonrpc': '2.0',
                  'method': 'user.addmedia',
                  'params': {
                      'users': [
                          {
                              'userid': 0
                          }
                      ],
                      'medias': {
                          'mediatypeid': '1',

                      }
                  },
                  'auth': authid,
                  'id': 1}
        data = json.dumps(values)
        req = urllib2.Request(url, data,
                              {'Content-Type': 'application/json-rpc'})
        response = urllib2.urlopen(req, data)
        output = json.loads(response.read())

        if 'result' in output:
            return True
        else:
            return False
    else:
        return False


def main():
    """Parse arguments and call sub-functions accordingly"""
    zbxurl = 'http://localhost/zabbix/api_jsonrpc.php'
    zbxuser = 'Admin'
    zbxpass = 'zabbix'

    parser = argparse.ArgumentParser(description='Import all given xml files '
                                                 'into a Zabbixserver at the '
                                                 'specified location')
    parser.add_argument('-z', dest='serveraddress', type=str,
                        help='Zabbixserver IP.')
    parser.add_argument('-u', dest='username', type=str,
                        help='Zabbix username')
    parser.add_argument('-p', dest='password', type=str,
                        help='Zabbix password')
    parser.add_argument('-a', action='store_true', default='False',
                        dest='autoregister', help='Enable autoregistration')
    parser.add_argument('-t', action='store_true', default='False',
                        dest='typeupdate', help='Set type to zabbix(active) ' +
                        'for template items')
    parser.add_argument('-n', dest='filenames', nargs='*', type=str,
                        help='Path to template xml files')

    args = parser.parse_args()
    files = args.filenames

    if args.serveraddress is not None:
        zbxurl = 'http://' + args.serveraddress + '/zabbix/api_jsonrpc.php'
    if args.username is not None:
        zbxuser = args.username
    if args.password is not None:
        zbxpass = args.password

    try:
        auth = zbx_auth(zbxurl, zbxuser, zbxpass)
    except urllib2.URLError, error:
        print 'Error on connection to zabbix:' + str(error.args)

    if files is not None:
        zbx_import(files, zbxurl, auth)
    if args.autoregister is True:
        zbx_add_autoregistration(zbxurl, auth)
    if args.typeupdate is True:
        zbx_set_items_to_active(zbxurl, auth)


if __name__ == '__main__':
    main()
