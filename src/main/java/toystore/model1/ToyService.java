package toystore.model1;

import toystore.model1.Toy;
import java.util.*;
import java.io.*;

public class ToyService {

    // File path where toys will be stored
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive\\Desktop\\ToyStore\\toy-store-project-WD09.02-178\\data\\toys.txt";

    // Save a single toy to file (appends to file)
    public void saveToy(Toy toy) throws IOException {
        try (FileWriter fw = new FileWriter(FILE_PATH, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            out.println(toy.getId() + "," +
                    toy.getName() + "," +
                    toy.getCategory() + "," +
                    toy.getPrice() + "," +
                    toy.getStock() + "," +
                    toy.getBrand());
        }
    }

    // Load all toys from file
    public List<Toy> loadAllToys() throws IOException {
        List<Toy> toys = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return toys;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 6) {
                    Toy toy = new Toy(
                            parts[0], parts[1], parts[2],
                            Double.parseDouble(parts[3]),
                            Integer.parseInt(parts[4]),
                            parts[5]
                    );
                    toys.add(toy);
                }
            }
        }
        return toys;
    }

    // Find a toy by ID
    public Toy findToyById(String id) throws IOException {
        List<Toy> toys = loadAllToys();
        for (Toy toy : toys) {
            if (toy.getId().equals(id)) {
                return toy;
            }
        }
        return null;
    }

    // Update a toy
    public boolean updateToy(Toy updatedToy) throws IOException {
        List<Toy> toys = loadAllToys();
        boolean found = false;

        for (int i = 0; i < toys.size(); i++) {
            if (toys.get(i).getId().equals(updatedToy.getId())) {
                toys.set(i, updatedToy);
                found = true;
                break;
            }
        }

        if (found) {
            saveAllToys(toys);
        }
        return found;
    }

    // Delete a toy by ID
    public boolean deleteToy(String id) throws IOException {
        List<Toy> toys = loadAllToys();
        boolean removed = toys.removeIf(toy -> toy.getId().equals(id));

        if (removed) {
            saveAllToys(toys);
        }
        return removed;
    }

    // Save all toys (overwrites file)
    private void saveAllToys(List<Toy> toys) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (Toy toy : toys) {
                out.println(toy.getId() + "," +
                        toy.getName() + "," +
                        toy.getCategory() + "," +
                        toy.getPrice() + "," +
                        toy.getStock() + "," +
                        toy.getBrand());
            }
        }
    }
}