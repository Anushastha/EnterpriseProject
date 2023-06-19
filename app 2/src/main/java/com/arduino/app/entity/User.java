package com.arduino.app.entity;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class User {
    
    private String firstName;
    private String lastName;
    private String middleName;
    private String password;
    private String address;
    private Long contactNo;
    private String gender;
    private Date dob;
}
