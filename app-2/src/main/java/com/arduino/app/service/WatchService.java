package com.arduino.app.service;

import java.util.HashMap;
import java.util.concurrent.ExecutionException;

public interface WatchService {

    String getValue(String field) throws InterruptedException, ExecutionException;;
    <T> void writeValue(String field, T value);
    HashMap<String, Double> getAllValues() throws InterruptedException, ExecutionException;
}
