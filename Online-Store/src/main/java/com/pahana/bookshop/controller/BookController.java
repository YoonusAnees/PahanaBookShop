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
import java.util.UUID;

@WebServlet("/admin/Book")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,  // 1 MB
    maxFileSize = 1024 * 1024 * 10,       // 10 MB
    maxRequestSize = 1024 * 1024 * 15     // 15 MB
)
public class BookController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private BookService bookService;  
    
    @Override
    public void init() throws ServletException {
        bookService = BookService.getInstance(); 
    }

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

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Part imagePart = request.getPart("image");
        String fileName = extractFileName(imagePart);
        if (fileName == null || fileName.isEmpty()) {
            throw new ServletException("Image file is required");
        }

        String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

        String uploadPath = getServletContext().getRealPath("/uploads");
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        imagePart.write(uploadPath + File.separator + uniqueFileName);

        String imagePath = "/uploads/" + uniqueFileName;

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

        Part imagePart = request.getPart("image");
        String fileName = extractFileName(imagePart);
        String imagePath;

        if (fileName == null || fileName.isEmpty()) {
            imagePath = request.getParameter("existingImage");
        } else {
            String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;

            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            imagePart.write(uploadPath + File.separator + uniqueFileName);

            imagePath = "/uploads/" + uniqueFileName; // fixed: always starts with slash
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

    private String extractFileName(Part part) {
        if (part == null) return null;

        String contentDisp = part.getHeader("content-disposition");
        if (contentDisp == null) return null;

        for (String cd : contentDisp.split(";")) {
            if (cd.trim().startsWith("filename")) {
                String filename = cd.substring(cd.indexOf('=') + 1).trim();
                if (filename.startsWith("\"") && filename.endsWith("\"")) {
                    filename = filename.substring(1, filename.length() - 1);
                }
                return filename.substring(filename.lastIndexOf(File.separator) + 1);
            }
        }
        return null;
    }
}
