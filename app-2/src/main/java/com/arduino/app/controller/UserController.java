package com.arduino.app.controller;

import java.util.concurrent.ExecutionException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arduino.app.entity.User;
import com.arduino.app.service.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/api")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @PostMapping("/users")
    public ResponseEntity<String> saveUser(@RequestBody User user) throws InterruptedException, ExecutionException {
        String status = userService.saveUser(user);
        return new ResponseEntity<>("Success", HttpStatus.OK);
    }

    @GetMapping("/users/{number}")
    public ResponseEntity<User> getUser(@PathVariable("number") Long number, HttpServletRequest request) throws InterruptedException, ExecutionException {
        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("sessionUser") != null) {
            User user = userService.getUser(number);
            if (user != null) {
                return ResponseEntity.ok(user); 
            } else {
                return ResponseEntity.notFound().build(); 
            }
        } else {
            return ResponseEntity.status(HttpStatus.FORBIDDEN).build(); 
        }
}

    @DeleteMapping("/users/{number}")
    public ResponseEntity<String> deleteUser(@PathVariable("number") Long number, HttpServletRequest request) {
        if (request.getSession() != null) {
            if (userService.deleteUser(number) != null) {
                return new ResponseEntity<>(null,HttpStatus.NOT_FOUND);
            }
            return new ResponseEntity<>( "Successfully deleted user: " + number.toString(),HttpStatus.OK);
        }
        return new ResponseEntity<>( "Unauthorized",HttpStatus.FORBIDDEN);
    }

    @PostMapping("/auth")
    public ResponseEntity<User> getAuth(@RequestBody User user, HttpServletRequest request) throws InterruptedException, ExecutionException {
        if (user.getPassword().equals(userService.getUser(user.getContactNo()).getPassword())) {
            request.getSession().setAttribute("sessionUser", userService.getUser(user.getContactNo()));
            return new ResponseEntity<>(userService.getUser(user.getContactNo()), HttpStatus.OK);
        }
         return new ResponseEntity<>( null ,HttpStatus.FORBIDDEN);
    }
}
