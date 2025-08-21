package com.pahana.test;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.service.OrderService;
import com.pahana.bookshop.DAO.DBConnectionFactory;

import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

@TestInstance(TestInstance.Lifecycle.PER_CLASS)
public class OrderServiceTest {

    private Connection conn;
    private OrderService orderService;

    @BeforeAll
    public void setup() throws SQLException {
        conn = DBConnectionFactory.getConnection();
        conn.setAutoCommit(false); 
        orderService = OrderService.getInstance();
    }

    @AfterAll
    public void cleanup() throws SQLException {
        conn.rollback(); // rollback changes
        conn.close();
    }

    private void printOrder(Order order) {
        System.out.println("------ Order Details ------");
        System.out.println("Order ID: " + order.getId());
        System.out.println("Customer ID: " + order.getCustomerId());
        System.out.println("Full Name: " + order.getFullName());
        System.out.println("Email: " + order.getEmail());
        System.out.println("Address: " + order.getAddress());
        System.out.println("Order Date: " + order.getOrderDate());
        System.out.println("Total : " + order.getTotal());
        System.out.println("Items:");
        if (order.getItems() != null) {
            for (OrderItem item : order.getItems()) {
                System.out.println("  BookId: " + item.getBookId() +
                                   ", StationeryId: " + item.getStationeryId() +
                                   ", Quantity: " + item.getQuantity() +
                                   ", Price: " + item.getPrice());
            }
        }
        System.out.println("---------------------------\n");
    }

    @Test
    public void testCreateAndDeleteOrder() throws Exception {
        // 1️⃣ Create order
        OrderItem item = new OrderItem();
        item.setBookId(31); 
        item.setQuantity(2);
        item.setPrice(5000.0);

        Order order = new Order();
        order.setCustomerId(1); 
        order.setFullName("Test User");
        order.setEmail("test@example.com");
        order.setAddress("123 Test St");
        order.setItems(Arrays.asList(item));

        int orderId = orderService.insertOrder(order); 
        Assertions.assertTrue(orderId > 0, "Order ID should be generated");

        Order fetched = orderService.getOrderById(orderId);
        Assertions.assertNotNull(fetched, "Order should exist after insert");
        Assertions.assertEquals(10000.0, fetched.getTotal(), "Total should be 2*5000");
        printOrder(fetched);
        orderService.deleteOrder(orderId);
        Order deleted = orderService.getOrderById(orderId);
        Assertions.assertNull(deleted, "Order should be deleted");
    }

    @Test
    public void testFetchSingleOrder() throws Exception {
        int orderId = 1; // Change to an existing order ID
        Order order = orderService.getOrderById(orderId);

        Assertions.assertNotNull(order, "Order should exist");
        printOrder(order);
    }

    @Test
    public void testFetchAllOrders() throws Exception {
        List<Order> orders = orderService.getAllOrdersWithItems(); // fetch with items
        Assertions.assertNotNull(orders);
        Assertions.assertTrue(orders.size() > 0, "Server should have at least one order");

        System.out.println("------ All Server Orders ------");
        for (Order order : orders) {
            printOrder(order);
        }
    }

    @Test
    public void testCalculateTotalOrder() throws Exception {
        int orderId = 1; // existing order ID
        Order order = orderService.getOrderById(orderId);

        Assertions.assertNotNull(order, "Order should exist");
        double dynamicTotal = order.getTotal();
        System.out.println("Dynamic total for order " + orderId + ": " + dynamicTotal);

        Assertions.assertTrue(dynamicTotal > 0, "Total should be greater than 0");
    }
}
