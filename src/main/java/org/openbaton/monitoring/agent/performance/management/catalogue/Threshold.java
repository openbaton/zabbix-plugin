package org.openbaton.monitoring.agent.performance.management.catalogue;

import org.openbaton.catalogue.util.IdGenerator;

import java.util.List;

/**
 * Created by mob on 25.11.15.
 */
public class Threshold {
    private String thresholdId;
    private List<ObjectSelection> objectSelectors;
    private String performanceMetric;
    private ThresholdType thresholdType;
    private ThresholdDetails thresholdDetails;

    public Threshold(List<ObjectSelection> objectSelectors, String performanceMetric, ThresholdType thresholdType, ThresholdDetails thresholdDetails) {
        this.objectSelectors = objectSelectors;
        this.performanceMetric = performanceMetric;
        this.thresholdType = thresholdType;
        this.thresholdDetails = thresholdDetails;
    }

    public String getThresholdId() {
        return thresholdId;
    }

    public void setThresholdId(String thresholdId) {
        this.thresholdId = thresholdId;
    }

    public List<ObjectSelection> getObjectSelectors() {
        return objectSelectors;
    }

    public void setObjectSelectors(List<ObjectSelection> objectSelectors) {
        this.objectSelectors = objectSelectors;
    }

    public String getPerformanceMetric() {
        return performanceMetric;
    }

    public void setPerformanceMetric(String performanceMetric) {
        this.performanceMetric = performanceMetric;
    }

    public ThresholdType getThresholdType() {
        return thresholdType;
    }

    public void setThresholdType(ThresholdType thresholdType) {
        this.thresholdType = thresholdType;
    }

    public ThresholdDetails getThresholdDetails() {
        return thresholdDetails;
    }

    public void setThresholdDetails(ThresholdDetails thresholdDetails) {
        this.thresholdDetails = thresholdDetails;
    }

    @Override
    public String toString() {
        return "Threshold{" +
                "thresholdId='" + thresholdId + '\'' +
                ", objectSelectors=" + objectSelectors +
                ", performanceMetric='" + performanceMetric + '\'' +
                ", thresholdType=" + thresholdType +
                ", thresholdDetails=" + thresholdDetails +
                '}';
    }
}
