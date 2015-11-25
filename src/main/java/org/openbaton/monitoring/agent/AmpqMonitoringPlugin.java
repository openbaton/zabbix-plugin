package org.openbaton.monitoring.agent;

import org.openbaton.monitoring.agent.interfaces.VirtualisedResourceFaultManagement;
import org.openbaton.monitoring.agent.interfaces.VirtualisedResourcesPerformanceManagement;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.concurrent.TimeoutException;

/**
 * Created by mob on 25.11.15.
 */
public abstract class AmpqMonitoringPlugin implements VirtualisedResourceFaultManagement,VirtualisedResourcesPerformanceManagement {

    protected Properties properties;
    private Logger log = LoggerFactory.getLogger(this.getClass());

    public AmpqMonitoringPlugin(){

    }



    protected void loadProperties() {
        properties = new Properties();
        log.debug("Loading properties");
        try {
            properties.load(this.getClass().getResourceAsStream("/plugin.conf.properties"));
            if (properties.getProperty("external-properties-file") != null) {
                File externalPropertiesFile = new File(properties.getProperty("external-properties-file"));
                if (externalPropertiesFile.exists()) {
                    log.debug("Loading properties from external-properties-file: " + properties.getProperty("external-properties-file"));
                    InputStream is = new FileInputStream(externalPropertiesFile);
                    properties.load(is);
                } else {
                    log.debug("external-properties-file: " + properties.getProperty("external-properties-file") + " doesn't exist");
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        log.debug("Loaded properties: " + properties);
    }
}
