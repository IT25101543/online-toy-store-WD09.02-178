package toystore.model1;

public class Toy {
    private String id;
    private String name;
    private String category;
    private double price;
    private int stock;
    private String brand;


    public Toy(String id, String name, String category, double price, int stock, String brand) {
        this.id = id;
        this.name = name;
        this.category = category;
        this.price = price;
        this.stock = stock;
        this.brand = brand;
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }


    public String getDetails(){
        return "ID: " + id + " | Name: " + name + " | Brand: " + brand +
                " | Category: " + category + " | Price: $" + price +
                " | Stock: " + stock;
    }
}



