package com.arduino.app.controller;

import java.util.concurrent.ExecutionException;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arduino.app.entity.User;
import com.arduino.app.service.UserService;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/api")
@AllArgsConstructor
public class UserController {
    
    private final UserService productService;

    @PostMapping("/users")
    public String saveProduct(@RequestBody User user) throws InterruptedException, ExecutionException{
        return productService.saveUser(user);
    }

    @GetMapping("/users/{name}")
    public User geProduct(@PathVariable("name") String name) throws InterruptedException, ExecutionException{
        return productService.getUser(name);
    }

    @PostMapping("/auth")
    public boolean getAuth(@RequestBody User user) throws InterruptedException, ExecutionException{
        return(productService.getUser(user.getContactNo().toString()).getPassword().equals(user.getPassword()) ? true : false );
    }

}
