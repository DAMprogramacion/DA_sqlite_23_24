package bd;

public class Mobile   {
    private String serial;
    private String model;
    private double price;

    public Mobile(String serial, String model, double price) {
        this.serial = serial;
        this.model = model;
        this.price = price;
    }

    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    @Override
    public String toString() {
        return String.format("%s,%s,%.2f", serial, model, price);
    }
}
