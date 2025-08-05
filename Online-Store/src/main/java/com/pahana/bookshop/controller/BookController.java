package com.pahana.bookshop.controller;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.service.BookService;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/Book")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
public class BookController extends HttpServlet {

    private final BookService bookService = new BookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteBook(request, response);
                    break;
                case "list":
                default:
                    listBooks(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    insertBook(request, response);
                    break;
                case "update":
                    updateBook(request, response);
                    break;
                default:
                    response.sendRedirect("Book?action=list");
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        List<Book> books = bookService.getAllBooks();
        request.setAttribute("bookList", books);
        request.getRequestDispatcher("/admin/BookList.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Book book = bookService.getBookById(id);
        request.setAttribute("book", book);
        request.getRequestDispatcher("/admin/EditBook.jsp").forward(request, response);
    }

    private void insertBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {

        // Read form fields
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Handle file upload
        Part imagePart = request.getPart("image");
        String fileName = extractFileName(imagePart);

        // Folder to save uploaded files (e.g., webapp/uploads)
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        String filePath = uploadPath + File.separator + fileName;
        imagePart.write(filePath);

        // Save relative path to DB
        String imagePath = "uploads/" + fileName;

        Book book = new Book(title, author, category, price, quantity, imagePath);

        bookService.addBook(book);

        response.sendRedirect("Book?action=list");
    }

    private void updateBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ServletException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Check if new image is uploaded
        Part imagePart = request.getPart("image");
        String fileName = extractFileName(imagePart);
        String imagePath;

        if (fileName == null || fileName.isEmpty()) {
            // No new image uploaded, keep old image
            imagePath = request.getParameter("existingImage");
        } else {
            // Save new image
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            String filePath = uploadPath + File.separator + fileName;
            imagePart.write(filePath);

            imagePath = "uploads/" + fileName;
        }

        Book book = new Book(id, title, author, category, price, quantity, imagePath);

        bookService.updateBook(book);

        response.sendRedirect("Book?action=list");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        bookService.deleteBook(id);
        response.sendRedirect("Book?action=list");
    }

    // Helper method to get filename from Part header
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
                return filename.substring(filename.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }
}
