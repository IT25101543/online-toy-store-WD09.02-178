package toystore.order;

import java.time.LocalDateTime;

public class TestOrderService {
    public static void main(String[] args) {
        try {
            OrderService service = new OrderService();

            // Create orders
            Order order1 = new Order("ORD001", "U001", "T001", 2, LocalDateTime.now(), "Pending");
            Order order2 = new Order("ORD002", "U002", "T002", 1, LocalDateTime.now(), "Shipped");
            Order order3 = new Order("ORD003", "U001", "T003", 3, LocalDateTime.now(), "Delivered");

            // Save orders
            service.saveOrder(order1);
            service.saveOrder(order2);
            service.saveOrder(order3);
            System.out.println("✅ 3 orders saved successfully!");

            // Load and display all orders
            System.out.println("\n📋 All Orders:");
            for (Order o : service.loadAllOrders()) {
                System.out.println(o.getDetails());
            }

            // Find order by ID
            Order found = service.findOrderById("ORD001");
            if (found != null) {
                System.out.println("\n🔍 Found order: " + found.getOrderID() + " | Status: " + found.getStatus());
            }

            // Find orders by User ID (U001)
            System.out.println("\n📋 Orders for User U001:");
            for (Order o : service.findOrdersByUserId("U001")) {
                System.out.println(o.getDetails());
            }

            // Update order status
            found.setStatus("Delivered");
            service.updateOrder(found);
            System.out.println("\n✏️ Order ORD001 status updated to: Delivered");

            // Delete an order
            service.deleteOrder("ORD002");
            System.out.println("\n🗑️ Order ORD002 deleted!");

            // Show remaining orders
            System.out.println("\n📋 Remaining Orders:");
            for (Order o : service.loadAllOrders()) {
                System.out.println(o.getDetails());
            }

            // Show total count
            System.out.println("\n📊 Total orders in system: " + service.loadAllOrders().size());

        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}