package toystore.order;

import java.time.LocalDateTime;
public class Order {
    private String orderID;
    private String userID;
    private String toyID;
    private int quantity;
    private LocalDateTime orderDate;
    private String status;

    public Order(String orderID, String userID, String toyID, int quantity, LocalDateTime orderDate, String status) {
        this.orderID = orderID;
        this.userID = userID;
        this.toyID = toyID;
        this.quantity = quantity;
        this.orderDate = orderDate;
        this.status = status;
    }

    public String getOrderID() {
        return orderID;
    }

    public void setOrderID(String orderID) {
        this.orderID = orderID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getToyID() {
        return toyID;
    }

    public void setToyID(String toyID) {
        this.toyID = toyID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDetails(){
        return "OrderID: " + orderID + " | UserID: " + userID + " | ToyID: " + toyID +
                " | Quantity: " + quantity +
                " | OrderDate: " + orderDate +
                " | Status: " + status;
    }

}
