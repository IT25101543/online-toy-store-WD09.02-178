package toystore.user;

import java.util.*;
import java.io.*;

public class UserService {

    // File path for storing users
    private static final String FILE_PATH = "data/users.txt";

    // Save a single user to file (appends)
    public void saveUser(User user) throws IOException {
        try (FileWriter fw = new FileWriter(FILE_PATH, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            out.println(user.getUserID() + "," +
                    user.getFullName() + "," +
                    user.getEmail() + "," +
                    user.getPassword() + "," +
                    user.getAddress());
        }
    }

    // Load all users from file
    public List<User> loadAllUsers() throws IOException {
        List<User> users = new ArrayList<>();
        File file = new File(FILE_PATH);

        if (!file.exists()) {
            return users;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    User user = new User(
                            parts[0], parts[1], parts[2], parts[3], parts[4]
                    );
                    users.add(user);
                }
            }
        }
        return users;
    }

    // Find a user by ID
    public User findUserById(String userID) throws IOException {
        List<User> users = loadAllUsers();
        for (User user : users) {
            if (user.getUserID().equals(userID)) {
                return user;
            }
        }
        return null;
    }

    // Update a user
    public boolean updateUser(User updatedUser) throws IOException {
        List<User> users = loadAllUsers();
        boolean found = false;

        for (int i = 0; i < users.size(); i++) {
            if (users.get(i).getUserID().equals(updatedUser.getUserID())) {
                users.set(i, updatedUser);
                found = true;
                break;
            }
        }

        if (found) {
            saveAllUsers(users);
        }
        return found;
    }

    // Delete a user by ID
    public boolean deleteUser(String userID) throws IOException {
        List<User> users = loadAllUsers();
        boolean removed = users.removeIf(user -> user.getUserID().equals(userID));

        if (removed) {
            saveAllUsers(users);
        }
        return removed;
    }

    // Save all users (overwrites file)
    private void saveAllUsers(List<User> users) throws IOException {
        try (PrintWriter out = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            for (User user : users) {
                out.println(user.getUserID() + "," +
                        user.getFullName() + "," +
                        user.getEmail() + "," +
                        user.getPassword() + "," +
                        user.getAddress());
            }
        }
    }
}