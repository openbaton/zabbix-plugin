package org.openbaton.monitoring.agent.performance.management.catalogue;

import org.openbaton.catalogue.mano.common.monitoring.ObjectSelection;
import org.openbaton.catalogue.util.IdGenerator;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by mob on 24.11.15.
 */
public class PmJob {
    private String pmjobId;
    private ObjectSelection objectSelection;
    private Map<String,String> performanceMetrics;
    private List<String> performanceMetricsGroup;
    private Integer collectionPeriod;
    private Integer reportingPeriod;
    private Integer reportingBoundary;

    public PmJob(ObjectSelection resourceSelector, Integer collectionPeriod) {
        this.objectSelection = resourceSelector;
        this.collectionPeriod = collectionPeriod;
        this.pmjobId= IdGenerator.createUUID();
        this.performanceMetrics=new HashMap<>();
    }

    public String getPmjobId() {
        return pmjobId;
    }

    public void setPmjobId(String pmjobId) {
        this.pmjobId = pmjobId;
    }

    public ObjectSelection getObjectSelection() {
        return objectSelection;
    }

    public void setObjectSelection(ObjectSelection objectSelection) {
        this.objectSelection = objectSelection;
    }

    public String getPerformanceMetric(String performanceMetricId) {
        return this.performanceMetrics.get(performanceMetricId);
    }

    public Set<String> getPerformanceMentricIds(){
        return performanceMetrics.keySet();
    }

    public void addPerformanceMetric(String performanceMetricId, String performanceMetric) {
        this.performanceMetrics.put(performanceMetricId,performanceMetric);
    }

    public List<String> getPerformanceMetricsGroup() {
        return performanceMetricsGroup;
    }

    public void setPerformanceMetricsGroup(List<String> performanceMetricsGroup) {
        this.performanceMetricsGroup = performanceMetricsGroup;
    }

    public Integer getCollectionPeriod() {
        return collectionPeriod;
    }

    public void setCollectionPeriod(Integer collectionPeriod) {
        this.collectionPeriod = collectionPeriod;
    }

    public Integer getReportingPeriod() {
        return reportingPeriod;
    }

    public void setReportingPeriod(Integer reportingPeriod) {
        this.reportingPeriod = reportingPeriod;
    }

    public Integer getReportingBoundary() {
        return reportingBoundary;
    }

    public void setReportingBoundary(Integer reportingBoundary) {
        this.reportingBoundary = reportingBoundary;
    }
}
