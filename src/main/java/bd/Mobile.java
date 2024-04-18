package bd;

import java.util.Objects;

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

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Mobile mobile = (Mobile) o;
        return Objects.equals(serial, mobile.serial);
    }

    @Override
    public int hashCode() {
        return Objects.hash(serial);
    }
}
