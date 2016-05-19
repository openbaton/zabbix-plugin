/*
* Copyright (c) 2015-2016 Fraunhofer FOKUS
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*      http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

package org.openbaton.monitoring.agent.connectivitymanager;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.mashape.unirest.http.HttpMethod;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.exceptions.UnirestException;
import org.openbaton.monitoring.agent.RestSender;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.net.HttpURLConnection;

/**
 * Created by mob on 27.01.16.
 */
public class ConnectivityManagerClient {
    private String url;
    private RestSender restSender;
    private Logger log = LoggerFactory.getLogger(this.getClass());
    private Gson mapper;


    public ConnectivityManagerClient(String ip, String port, RestSender restSender){
        if(ip==null || port==null || ip.isEmpty() || port.isEmpty())
            throw new NullPointerException("ConnectivityManagerClient: Ip or port null or empty");
        url=ip+":"+port;
        this.restSender=restSender;
        mapper= new GsonBuilder().setPrettyPrinting().create();
    }

    public Host getHost() throws UnirestException {
        String url = this.url + "/hosts";
        HttpResponse<String> hosts = restSender.doRestCallWithJson(url,"", HttpMethod.GET,"");

        log.debug("hosts " + hosts.getBody());
        log.debug("response status " + hosts.getCode());
        if(hosts.getCode()!= HttpURLConnection.HTTP_OK){
            log.error("Received status: "+hosts.getCode());
            return null;
        }
        else{
            return mapper.fromJson(hosts.getBody(),Host.class);
        }
    }

    public String getDatacenterFromVM(String vmHostname) throws UnirestException {
        Host host = getHost();
        // Check if the vmHostname is not a datacenter
        if(!host.isDatacenter(vmHostname))
            return host.belongsTo(vmHostname);
        return null;
    }
}
