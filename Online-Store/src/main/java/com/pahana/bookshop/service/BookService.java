package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.BookDAO;
import com.pahana.bookshop.model.Book;

import java.sql.SQLException;
import java.util.List;

public class BookService {

    private final BookDAO bookDAO = new BookDAO();

    public void addBook(Book book) throws SQLException {
        bookDAO.insertBook(book);
    }

    public Book getBookById(int id) throws SQLException {
        return bookDAO.selectBook(id);
    }

    public List<Book> getAllBooks() throws SQLException {
        return bookDAO.selectAllBooks();
    }
    
    public List<Book> getAllBookss() {
        try {
            return bookDAO.selectAllBooks();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateBook(Book book) throws SQLException {
        bookDAO.updateBook(book);
    }

    public void deleteBook(int id) throws SQLException {
        bookDAO.deleteBook(id);
    }
}
