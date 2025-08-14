package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    private static final String INSERT_BOOK_SQL = "INSERT INTO books (title, author, category, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_BOOK_BY_ID = "SELECT * FROM books WHERE id = ?";
    private static final String SELECT_ALL_BOOKS = "SELECT * FROM books";
    private static final String UPDATE_BOOK_SQL = "UPDATE books SET title = ?, author = ?, category = ?, price = ?, quantity = ?, image = ? WHERE id = ?";
    private static final String DELETE_BOOK_SQL = "DELETE FROM books WHERE id = ?";

    public boolean insertBook(Book book) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_BOOK_SQL)) {

            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setDouble(4, book.getPrice());
            ps.setInt(5, book.getQuantity());
            ps.setString(6, book.getImage());

            int rowsInserted = ps.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Book selectBook(int id) throws SQLException {
        Book book = null;
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_BOOK_BY_ID)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                book = new Book(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("category"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getString("image")
                );
            }
        }
        return book;
    }
    
    public Book selectBookById(int id) throws SQLException {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Book book = new Book();
                    book.setId(rs.getInt("id"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setCategory(rs.getString("category"));
                    book.setPrice(rs.getDouble("price"));
                    book.setQuantity(rs.getInt("quantity"));
                    book.setImage(rs.getString("image"));
                    return book;
                }
            }
        }
        return null;
    }

    

    public List<Book> selectAllBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_BOOKS);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                books.add(new Book(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("category"),
                    rs.getDouble("price"),
                    rs.getInt("quantity"),
                    rs.getString("image")
                ));
            }
        }
        return books;
    }

    public void updateBook(Book book) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_BOOK_SQL)) {
            ps.setString(1, book.getTitle());
            ps.setString(2, book.getAuthor());
            ps.setString(3, book.getCategory());
            ps.setDouble(4, book.getPrice());
            ps.setInt(5, book.getQuantity());
            ps.setString(6, book.getImage());
            ps.setInt(7, book.getId());
            ps.executeUpdate();
        }
    }

    public void deleteBook(int id) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_BOOK_SQL)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        }
    }
}
