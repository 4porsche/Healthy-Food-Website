package model;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {
    private List<CartItem> items = new ArrayList<>();
    
    public void addItem(CartItem newItem) {
        for (CartItem item : items) {
            if (item.getProductID() == newItem.getProductID()) {
                item.setQuantity(item.getQuantity() + newItem.getQuantity());
                return;
            }
        }
        items.add(newItem);
    }
    
    public void updateQuantity(int productID, int quantity) {
        for (CartItem item : items) {
            if (item.getProductID() == productID) {
                item.setQuantity(quantity);
                return;
            }
        }
    }
    
    public void removeItem(int productID) {
        Iterator<CartItem> iterator = items.iterator();
        while (iterator.hasNext()) {
            CartItem item = iterator.next();
            if (item.getProductID() == productID) {
                iterator.remove();
                return;
            }
        }
    }
    
    public double getTotal() {
        double total = 0;
        for (CartItem item : items) {
            total += item.getTotalPrice();
        }
        return total;
    }
    
    public List<CartItem> getItems() {
        return items;
    }
    
    public int getTotalItems() {
        return items.size();
    }
    
    public void clear() {
        items.clear();
    }
    
    public boolean isEmpty() {
        return items.isEmpty();
    }
}