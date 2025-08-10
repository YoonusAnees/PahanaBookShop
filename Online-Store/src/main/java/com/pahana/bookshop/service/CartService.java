package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.CartDAO;
import com.pahana.bookshop.model.CartItem;

import java.util.List;

public class CartService {
    private final CartDAO cartDAO = new CartDAO();

    public void addToCart(int customerId, int bookId, int quantity) {
        CartItem existingItem = cartDAO.findCartItem(customerId, bookId);
        if (existingItem != null) {
            int newQty = existingItem.getQuantity() + quantity;
            cartDAO.updateQuantity(existingItem.getId(), newQty);
        } else {
            cartDAO.addToCart(customerId, bookId, quantity);
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
            cartDAO.reduceBookStock(item.getBook().getId(), item.getQuantity());
        }
        cartDAO.clearCartByCustomer(customerId);
    }

    public void updateStockAfterOrder(int customerId) {
        List<CartItem> cartItems = cartDAO.getCartItemsByCustomerId(customerId);
        for (CartItem item : cartItems) {
            cartDAO.reduceBookStock(item.getBook().getId(), item.getQuantity());
        }
    }
}
