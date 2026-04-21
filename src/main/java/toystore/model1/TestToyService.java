package toystore.model1;

public class TestToyService {
    public static void main(String[] args) {
        try {
            ToyService service = new ToyService();

            // 1. Create a new toy
            Toy toy1 = new Toy("T001", "Teddy Bear", "Soft Toys", 15.99, 50, "Brown Bear Co.");
            Toy toy2 = new Toy("T002", "Lego Set", "Building Blocks", 29.99, 30, "Lego");

            // 2. Save toys to file
            service.saveToy(toy1);
            service.saveToy(toy2);
            System.out.println(" Toys saved successfully!");

            // 3. Load all toys and display
            System.out.println("\n All Toys in Store:");
            for (Toy t : service.loadAllToys()) {
                System.out.println(t.getDetails());
            }

            // 4. Find a toy by ID
            Toy found = service.findToyById("T001");
            if (found != null) {
                System.out.println("\n Found toy: " + found.getName());
            }

            // 5. Update a toy
            found.setPrice(17.99);
            found.setStock(45);
            service.updateToy(found);
            System.out.println("\n Toy updated!");

            // 6. Display updated toy
            Toy updated = service.findToyById("T001");
            System.out.println("Updated: " + updated.getDetails());

            // 7. Delete a toy
            service.deleteToy("T002");
            System.out.println("\n Toy T002 deleted!");

            // 8. Show remaining toys
            System.out.println("\n Remaining Toys:");
            for (Toy t : service.loadAllToys()) {
                System.out.println(t.getDetails());
            }

        } catch (Exception e) {
            System.out.println(" Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}