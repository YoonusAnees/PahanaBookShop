package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

	   public boolean insertUser(User user) {
	        String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
	        try (Connection conn = DBConnectionFactory.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(sql)) {

	            stmt.setString(1, user.getUsername());
	            stmt.setString(2, user.getEmail());
	            stmt.setString(3, user.getPassword());
	            stmt.setString(4, user.getRole());

	            int rowsInserted = stmt.executeUpdate();
	            return rowsInserted > 0;

	        } catch (SQLException e) {
	            e.printStackTrace();
	            return false;
	        }
	    }
	   
	   
	   public int insertUserAndReturnId(User user) {
		    String sql = "INSERT INTO users (username, email, password, role) VALUES (?, ?, ?, ?)";
		    try (Connection conn = DBConnectionFactory.getConnection();
		         PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

		        stmt.setString(1, user.getUsername());
		        stmt.setString(2, user.getEmail());
		        stmt.setString(3, user.getPassword());
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
		    String query = "SELECT * FROM users";

		    try (Connection connection = DBConnectionFactory.getConnection();
		         Statement stmt = connection.createStatement();
		         ResultSet rs = stmt.executeQuery(query)) {

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
//		    System.out.println("Users loaded: " + users.size());


		    return users;
		}


    // Get user by ID
    public User getUserById(int id) {
        String query = "SELECT * FROM users WHERE id = ?";
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),  // added email
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
        String query = "UPDATE users SET username = ?, email = ?, password = ?, role = ? WHERE id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());   // added email
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getRole());
            stmt.setInt(5, user.getId());
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Delete user by ID
    public void deleteUser(int id) {
        String query = "DELETE FROM users WHERE id = ?";

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setInt(1, id);
            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Validate login (used during login process)
    public User validateLogin(String username, String password) {
        String query = "SELECT * FROM users WHERE username = ? AND password = ?";
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),   // added email
                    rs.getString("password"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return user;
    }

    // Get user by username - to check if username exists
    public User getUserByUsername(String username) {
        String query = "SELECT * FROM users WHERE username = ?";
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                user = new User(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("email"),  // added email
                    rs.getString("password"),
                    rs.getString("role")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // (Optional) Get user by email - to check if email exists
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM users WHERE email = ?";
        User user = null;

        try (Connection connection = DBConnectionFactory.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

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
