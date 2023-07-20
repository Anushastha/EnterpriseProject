package com.arduino.app.controller;
import java.util.HashMap;
import java.util.concurrent.ExecutionException;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.arduino.app.service.WatchService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/api/watch")
@AllArgsConstructor
public class WatchController {
    private final WatchService watchService;
    public WatchController(WatchService watchService) {
        this.watchService = watchService;
    }

    private boolean checkSession(HttpSession session){
        return(session != null);
    }

    @GetMapping("/{field}")
    public ResponseEntity<String> readSensor(@PathVariable("field") String field, HttpServletRequest request) throws InterruptedException, ExecutionException{
        if(checkSession(request.getSession(false))){
            try {
                return new ResponseEntity<>(watchService.getValue(field),HttpStatus.OK);
            } catch (InterruptedException e) {
                e.printStackTrace();
            } catch (ExecutionException e) {
                e.printStackTrace();
            }
        }
        return new ResponseEntity<>("Unauthorized",HttpStatus.FORBIDDEN);
    }

    @PostMapping("/{field}")
    public ResponseEntity<String> writeSensor(@PathVariable("field") String field, @RequestBody String value, HttpServletRequest request){
        if(checkSession(request.getSession(false))){
            try{
                watchService.writeValue(field, value);
                return new ResponseEntity<>("Success",HttpStatus.OK);
            }
            catch(Exception e){
                return new ResponseEntity<>(null, HttpStatus.NOT_FOUND);
            }
            
        }
        return new ResponseEntity<>("Unauthorized",HttpStatus.FORBIDDEN);
    }

   @GetMapping({"/",""})
    public ResponseEntity<HashMap<String,Double>> getAllSensor(HttpServletRequest request) throws InterruptedException, ExecutionException{
        HashMap<String, Double> values = new HashMap<>();
        if(checkSession(request.getSession(false))){
            values = watchService.getAllValues();
            return new ResponseEntity<>(values, HttpStatus.OK);
        }
        return new ResponseEntity<>(null, HttpStatus.FORBIDDEN);
    }
}