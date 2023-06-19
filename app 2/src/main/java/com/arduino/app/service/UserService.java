package com.arduino.app.service;

import java.util.concurrent.ExecutionException;
import com.arduino.app.entity.User;

public interface UserService {
    
    public String saveUser(User product) throws InterruptedException, ExecutionException;
    public User getUser(String name) throws InterruptedException, ExecutionException;
}
