package com.pahana.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.UserService;

import java.util.List;

public class ValidateLogin {
 UserService userService;

    @BeforeEach
    public void setUp() {
        // Get singleton instance of UserService
        userService = UserService.getInstance();
    }

    @Test
    public void testValidateLogin() {


        User validatedUser = userService.validateLogin("jane@example.com", "siuu");
        assertNotNull(validatedUser, "Validated user should not be null");
        assertEquals("jane_doe", validatedUser.getUsername(), "Username should match");
    }

    
}
