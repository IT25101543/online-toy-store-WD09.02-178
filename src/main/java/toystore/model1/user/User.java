package toystore.user;

public class User {
    private String userID;
    private String fullName;
    private  String email;
    private String password;
    private String address;


    public User(String userID, String fullName, String email, String password, String address) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.address = address;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getUserDetails() {
        return "ID: " + userID + " | Name: " + fullName + " | Email: " + email + " | Address: " + address;
    }

}
