package org.openbaton.monitoring.agent;

import java.util.LinkedList;

/**
 * Created by tbr on 27.10.15.
 */
public class LimitedQueue<E> extends LinkedList<E> {
    private static final long serialVersionUID = 1L;
    private int limit;

    public LimitedQueue(int limit) {
        this.limit = limit;
    }

    @Override
    public boolean add(E o) {
        super.add(o);
        while (size() > limit) { super.remove(); }
        return true;
    }
}