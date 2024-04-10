package singleton;

public class Singleton1 {
    private static Singleton1 singleton1;

    private Singleton1() {
    }

    public static Singleton1 getSingleton1() {
        if (singleton1 == null)
            singleton1 = new  Singleton1();
        return singleton1;
    }


}
