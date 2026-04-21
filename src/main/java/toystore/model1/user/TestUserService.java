package toystore.user;

public class TestUserService {
    public static void main(String[] args) {
        try {
            UserService service = new UserService();

            // Create users
            User user1 = new User("U001", "John Doe", "john@email.com", "pass123", "Colombo");
            User user2 = new User("U002", "Jane Smith", "jane@email.com", "pass456", "Kandy");

            // Save users
            service.saveUser(user1);
            service.saveUser(user2);
            System.out.println("✅ Users saved!");

            // Load and display all users
            System.out.println("\n📋 All Users:");
            for (User u : service.loadAllUsers()) {
                System.out.println(u.getUserDetails());
            }

            // Find user by ID
            User found = service.findUserById("U001");
            if (found != null) {
                System.out.println("\n🔍 Found: " + found.getFullName());
            }

            // Update user
            found.setAddress("Galle");
            service.updateUser(found);
            System.out.println("\n✏️ User updated!");

            // Delete user
            service.deleteUser("U002");
            System.out.println("\n🗑️ User U002 deleted!");

            // Show remaining users
            System.out.println("\n📋 Remaining Users:");
            for (User u : service.loadAllUsers()) {
                System.out.println(u.getUserDetails());
            }

        } catch (Exception e) {
            System.out.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}