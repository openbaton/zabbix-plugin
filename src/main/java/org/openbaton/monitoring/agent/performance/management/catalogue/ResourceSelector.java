package org.openbaton.monitoring.agent.performance.management.catalogue;

import java.util.List;

/**
 * Created by mob on 18.11.15.
 */
public class ResourceSelector {

    private List<String> hostnames;

    public ResourceSelector(List<String> hostnames){
        this.hostnames=hostnames;
    }

    public List<String> getHostnames() {
        return hostnames;
    }

    public void setHostnames(List<String> hostnames) {
        this.hostnames = hostnames;
    }
}
