package com.pahana.bookshop.util;

import com.pahana.bookshop.DAO.UserDAO;
import com.pahana.bookshop.model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;
import java.util.Scanner;

public class PasswordMigration {
    
    public static void main(String[] args) {
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
        int migratedCount = 0;
        int alreadyHashed = 0;
        int errors = 0;
        
        System.out.println("==============================================");
        System.out.println("    PahanaBook Password Migration Utility");
        System.out.println("==============================================");
        System.out.println("Found " + users.size() + " users to check.");
        System.out.println();
        
        Scanner scanner = new Scanner(System.in);
        System.out.print("Do you want to proceed with password migration? (yes/no): ");
        String response = scanner.nextLine().trim().toLowerCase();
        
        if (!response.equals("yes") && !response.equals("y")) {
            System.out.println("Migration cancelled.");
            scanner.close();
            return;
        }
        
        System.out.println();
        System.out.println("Starting password migration...");
        System.out.println();
        
        for (User user : users) {
            try {
                String password = user.getPassword();
                String username = user.getUsername();
                String email = user.getEmail();
                
                System.out.println("Processing user: " + username + " (" + email + ")");
                
                // Check if password is already properly hashed with bcrypt
                if (password != null && password.startsWith("$2a$")) {
                    // Verify it's a valid bcrypt hash
                    try {
                        // This will throw an exception if it's not a valid bcrypt hash
                        BCrypt.checkpw("test", password);
                        alreadyHashed++;
                        System.out.println("✓ Already has valid bcrypt hash, skipping.");
                        continue;
                    } catch (Exception e) {
                        System.out.println("✗ Has invalid bcrypt hash, rehashing...");
                    }
                } else {
                    System.out.println("✗ Password is not hashed, hashing with bcrypt...");
                }
                
                // Hash the password with proper bcrypt
                String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                
                // Update the user with hashed password
                User updatedUser = new User(
                    user.getId(),
                    user.getUsername(),
                    user.getEmail(),
                    hashedPassword,
                    user.getRole()
                );
                
                userDAO.updateUserPasswordOnly(updatedUser);
                migratedCount++;
                System.out.println("✓ Successfully migrated password.");
                
            } catch (Exception e) {
                errors++;
                System.err.println("✗ Error migrating password: " + e.getMessage());
                e.printStackTrace();
            }
            System.out.println("----------------------------------------------");
        }
        
        System.out.println();
        System.out.println("==============================================");
        System.out.println("Password migration completed!");
        System.out.println("Migrated: " + migratedCount);
        System.out.println("Already hashed: " + alreadyHashed);
        System.out.println("Errors: " + errors);
        System.out.println("==============================================");
        
        scanner.close();
    }
}