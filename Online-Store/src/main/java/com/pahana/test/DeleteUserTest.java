package com.pahana.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.UserService;

import java.util.List;

public class DeleteUserTest {

	 private UserService userService;

	    @BeforeEach
	    public void setUp() {
	        userService = UserService.getInstance();
	    }

	  
	    @Test
	    public void testDeleteUser() {
	        User user = new User("temp_user", "temp@example.com", "temp123", "customer");
	        userService.insertUser(user);

	        User insertedUser = userService.validateLogin("temp@example.com", "temp123");
	        assertNotNull(insertedUser, "Inserted user should exist before deletion");

	        userService.deleteUser(insertedUser.getId());

	        User deletedUser = userService.getUserById(insertedUser.getId());
	        assertNull(deletedUser, "User should be deleted and not found in the system");
	    }
	}
