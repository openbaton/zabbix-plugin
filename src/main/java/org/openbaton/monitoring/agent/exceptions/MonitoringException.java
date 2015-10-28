package org.openbaton.monitoring.agent.exceptions;

/**
 * Created by tbr on 23.10.15.
 */
public class MonitoringException extends Exception {


    private static final long serialVersionUID = 1L;

    public MonitoringException() {
        super();
    }

    public MonitoringException(String arg0, Throwable arg1) {
        super(arg0, arg1);
    }

    public MonitoringException(String arg0) {
        super(arg0);
    }

    public MonitoringException(Throwable arg0) {
        super(arg0);
    }

}
