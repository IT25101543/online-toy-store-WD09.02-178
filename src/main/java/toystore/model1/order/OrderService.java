package toystore.order;

import java.util.*;
import java.io.*;
import java.time.LocalDateTime;

public class OrderService {

    // ABSOLUTE PATH - Change this to match YOUR computer path if different
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive\\Desktop\\ToyStore\\toy-store-project-WD09.02-178\\data\\orders.txt";

    // Save a single order to file (appends)
    public void saveOrder(Order order) throws IOException {
        try (FileWriter fw = new FileWriter(FILE_PATH, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            out.println(order.getOrderID() + "," +
                    order.getUserID() + "," +
                    order.getToyID() + "," +
                    order.getQuantity() + "," +
                    order.getOrderDate().toString() + "," +
                    order.getStatus());
        }
    }

    // Load all orders from file
    public List<Order> loadAllOrders() throws IOException {
        List<Order> orders = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return orders;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 6) {
                    Order order = new Order(
                            parts[0], parts[1], parts[2],
                            Integer.parseInt(parts[3]),
                            LocalDateTime.parse(parts[4]),
                            parts[5]
                    );
                    orders.add(order);
                }
            }
        }
        return orders;
    }

    // Find an order by ID
    public Order findOrderById(String orderID) throws IOException {
        List<Order> orders = loadAllOrders();
        for (Order order : orders) {
            if (order.getOrderID().equals(orderID)) {
                return order;
            }
        }
        return null;
    }

    // Find orders by User ID
    public List<Order> findOrdersByUserId(String userID) throws IOException {
        List<Order> orders = loadAllOrders();
        List<Order> userOrders = new ArrayList<>();
        for (Order order : orders) {
            if (order.getUserID().equals(userID)) {
                userOrders.add(order);
            }
        }
        return userOrders;
    }

    // Update an order
    public boolean updateOrder(Order updatedOrder) throws IOException {
        List<Order> orders = loadAllOrders();
        boolean found = false;

        for (int i = 0; i < orders.size(); i++) {
            if (orders.get(i).getOrderID().equals(updatedOrder.getOrderID())) {
                orders.set(i, updatedOrder);
                found = true;
                break;
            }
        }

        if (found) {
            saveAllOrders(orders);
        }
        return found;
    }

    // Delete an order by ID
    public boolean deleteOrder(String orderID) throws IOException {
        List<Order> orders = loadAllOrders();
        boolean removed = orders.removeIf(order -> order.getOrderID().equals(orderID));

        if (removed) {
            saveAllOrders(orders);
        }
        return removed;
    }

    // Save all orders (overwrites file)
    private void saveAllOrders(List<Order> orders) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Order order : orders) {
                out.println(order.getOrderID() + "," +
                        order.getUserID() + "," +
                        order.getToyID() + "," +
                        order.getQuantity() + "," +
                        order.getOrderDate().toString() + "," +
                        order.getStatus());
            }
        }
    }
}