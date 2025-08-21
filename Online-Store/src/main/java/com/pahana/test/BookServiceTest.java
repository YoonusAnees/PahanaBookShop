package com.pahana.test;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.service.BookService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.SQLException;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class BookServiceTest {

    private BookService bookService;

    @BeforeEach
    public void setUp() {
        bookService = BookService.getInstance();
    }

    @Test
    public void testAddAndGetBook() throws SQLException {
        Book book = new Book();
        book.setTitle("JUnit Testing Book");
        book.setAuthor("Test Author");
        book.setCategory("Testing");  
        book.setPrice(200.0);
        book.setQuantity(5);         
        book.setImage("test.png");     

        bookService.addBook(book);

        List<Book> allBooks = bookService.getAllBooks();
        Book lastBook = allBooks.get(allBooks.size() - 1);

        System.out.println("Added Book -> ID: " + lastBook.getId() + ", Title: " + lastBook.getTitle());
        assertEquals("JUnit Testing Book", lastBook.getTitle());
    }


    @Test
    public void testGetAllBooks() throws SQLException {
        List<Book> books = bookService.getAllBooks();

        System.out.println("Listing all books:");
        for (Book book : books) {
            System.out.println("ID: " + book.getId() +
                               ", Title: " + book.getTitle() +
                               ", Author: " + book.getAuthor() +
                               ", Price: " + book.getPrice());
        }

        assertNotNull(books);
    }

    @Test
    public void testUpdateBook() throws SQLException {
        List<Book> books = bookService.getAllBooks();
        if (books.isEmpty()) {
            fail("No books available to update.");
        }

        Book book = books.get(0);
        String oldTitle = book.getTitle();
        book.setTitle("Updated Title");

        bookService.updateBook(book);

        Book updatedBook = bookService.getBookById(book.getId());
        System.out.println("Updated Book -> ID: " + updatedBook.getId() + ", Title: " + updatedBook.getTitle());

        assertNotEquals(oldTitle, updatedBook.getTitle());
    }

    @Test
    public void testDeleteBook() throws SQLException {
        List<Book> books = bookService.getAllBooks();
        if (books.isEmpty()) {
            fail("No books available to delete.");
        }

        Book book = books.get(0);
        int bookId = book.getId();

        bookService.deleteBook(bookId);

        Book deletedBook = bookService.getBookById(bookId);
        System.out.println("Deleted Book ID: " + bookId);

        assertNull(deletedBook);
    }
}
