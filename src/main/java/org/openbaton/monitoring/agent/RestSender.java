package org.openbaton.monitoring.agent;

import com.mashape.unirest.http.HttpMethod;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.exceptions.UnirestException;

/**
 * Created by mob on 27.01.16.
 */
public interface RestSender {
    HttpResponse<String> doRestCallWithJson(String url, String json, HttpMethod method, String contentType) throws UnirestException;
}
