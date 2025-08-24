package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    
    private static final String INSERT_USER_SQL = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
    private static final String INSERT_USER_AND_RETURN_ID = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
    private static final String GET_ALL_USER =  "SELECT * FROM users";
    private static final String GET_USER_BY_ID = "SELECT * FROM users WHERE id = ?";
    private static final String UPDATE_USER = "UPDATE users SET username = ?, email = ?, password = ?, role = ? WHERE id = ?";
    private static final String DELETE_USER =  "DELETE FROM users WHERE id = ?";
    private static final String GET_BY_USERNAME = "SELECT * FROM users WHERE username = ?";
    private static final String GET_USER_BY_EMAIL = "SELECT * FROM users WHERE email = ?";
    
    public boolean insertUser(User user) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_USER_SQL)) {

            // Hash the password before storing
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getRole());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public int insertUserAndReturnId(User user) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_USER_AND_RETURN_ID, Statement.RETURN_GENERATED_KEYS)) {

            // Hash the password before storing
            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, user.getRole());

            int affectedRows = stmt.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Creating user failed, no rows affected.");
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating user failed, no ID obtained.");
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    // Retrieve all users
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();

        try (Connection connection = DBConnectionFactory.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_USER)) {

            while (rs.next()) {
                User user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }

    // Get user by ID
    public User getUserById(int id) {
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_USER_BY_ID)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Update user details
    public void updateUser(User user) {
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(UPDATE_USER)) {

            // Check if password is already hashed or needs to be hashed
            String passwordToStore;
            if (user.getPassword().startsWith("$2a$")) {
                // Password is already hashed (bcrypt format)
                passwordToStore = user.getPassword();
            } else {
                // Hash the new password
                passwordToStore = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
            }
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, passwordToStore);
            stmt.setString(4, user.getRole());
            stmt.setInt(5, user.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete user by ID
    public void deleteUser(int id) {
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(DELETE_USER)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User validateLogin(String email, String password) {
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_USER_BY_EMAIL)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                int userId = rs.getInt("id");
                String username = rs.getString("username");
                String role = rs.getString("role");
                
                
                try {
                    if (BCrypt.checkpw(password, storedHash)) {
                        user = new User(userId, username, email, storedHash, role);
                        
                        return user;
                    } else {
                    
                    }
                } catch (IllegalArgumentException e) {
                    System.out.println("✗ Invalid salt version: " + e.getMessage());
                    
                    if (storedHash != null && storedHash.equals(password)) {
                        System.out.println("✓ Password matches plain text, rehashing...");
                        
                        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
                        
                        User updatedUser = new User(userId, username, email, hashedPassword, role);
                        updateUserPasswordOnly(updatedUser);
                        
                        user = new User(userId, username, email, hashedPassword, role);
                    } else {
                        System.out.println("✗ Password does not match plain text either");
                    }
                }
            } else {
                System.out.println("✗ No user found with email: " + email);
            }

        } catch (SQLException e) {
            System.err.println("Database error during login: " + e.getMessage());
            e.printStackTrace();
        }

        return user;
    }
    
    public void updateUserPasswordOnly(User user) {
        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement("UPDATE users SET password = ? WHERE id = ?")) {

            stmt.setString(1, user.getPassword());
            stmt.setInt(2, user.getId());
            int rowsUpdated = stmt.executeUpdate();
            
            System.out.println("Updated password for user ID " + user.getId() + 
                              ", rows affected: " + rowsUpdated);

        } catch (SQLException e) {
            System.err.println("Error updating password: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    public void debugUserPasswords() {
        List<User> users = getAllUsers();
        System.out.println("=== User Password Debug Information ===");
        
        for (User user : users) {
            String password = user.getPassword();
            boolean isBcrypt = password != null && password.startsWith("$2a$");
            boolean looksLikeHash = password != null && password.length() > 20;
            
            System.out.println("User: " + user.getUsername() + 
                             " (" + user.getEmail() + ")");
            System.out.println("Password: " + (password != null ? 
                password.substring(0, Math.min(20, password.length())) + "..." : "null"));
            System.out.println("Is bcrypt format: " + isBcrypt);
            System.out.println("Looks like hash: " + looksLikeHash);
            System.out.println("-----------------------------------");
        }
    }
    
    public boolean fixUserPassword(String email, String newPassword) {
        try {
            User user = getUserByEmail(email);
            if (user == null) {
                System.out.println("User not found with email: " + email);
                return false;
            }
            
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            user.setPassword(hashedPassword);
            updateUserPasswordOnly(user);
            
            System.out.println("Fixed password for user: " + email);
            return true;
            
        } catch (Exception e) {
            System.err.println("Error fixing password: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
  

    public User getUserByUsername(String username) {
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_BY_USERNAME)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // Get user by email
    public User getUserByEmail(String email) {
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(GET_USER_BY_EMAIL)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
    

}