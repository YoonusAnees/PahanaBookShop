package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.CartDAO;
import com.pahana.bookshop.model.CartItem;
import java.util.List;

public class CartService {

    private static CartService instance;
    private final CartDAO cartDAO;

    private CartService() {
        this.cartDAO = new CartDAO();
    }

    public static CartService getInstance() {
        if (instance == null) {
            synchronized (CartService.class) {
                if (instance == null) {
                    instance = new CartService();
                }
            }
        }
        return instance;
    }

    public void addToCart(int customerId, Integer bookId, Integer stationeryId, int quantity) {
        CartItem existingItem = cartDAO.findCartItem(customerId, bookId, stationeryId);
        if (existingItem != null) {
            int newQty = existingItem.getQuantity() + quantity;
            cartDAO.updateQuantity(existingItem.getId(), newQty);
        } else {
            cartDAO.addToCart(customerId, bookId, stationeryId, quantity);
        }
    }

    public List<CartItem> getCartItems(int customerId) {
        return cartDAO.getCartItemsByCustomerId(customerId);
    }

    public void removeItem(int cartId) {
        cartDAO.removeCartItem(cartId);
    }

    public void checkout(int customerId) {
        List<CartItem> cartItems = cartDAO.getCartItemsByCustomerId(customerId);
        for (CartItem item : cartItems) {
            if (item.getBook() != null) {
                cartDAO.reduceBookStock(item.getBook().getId(), item.getQuantity());
            } else if (item.getStationery() != null) {
                cartDAO.reduceStationeryStock(item.getStationery().getId(), item.getQuantity());
            }
        }
        cartDAO.clearCartByCustomer(customerId);
    }

    public void updateStockAfterOrder(int customerId) {
        List<CartItem> cartItems = cartDAO.getCartItemsByCustomerId(customerId);
        for (CartItem item : cartItems) {
            cartDAO.reduceBookStock(item.getBook().getId(), item.getQuantity());
        }
    }
    
    public void updateQuantity(int cartId, int quantity) {
        cartDAO.updateQuantity(cartId, quantity);
    }
    
    public double getTotalPrice(int customerId) {
        List<CartItem> cartItems = getCartItems(customerId);
        double total = 0;
        for (CartItem item : cartItems) {
            if (item.getBook() != null) {
                total += item.getBook().getPrice() * item.getQuantity();
            } else if (item.getStationery() != null) {
                total += item.getStationery().getPrice() * item.getQuantity();
            }
        }
        return total;
    }

}
