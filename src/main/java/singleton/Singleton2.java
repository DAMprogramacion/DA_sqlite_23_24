package singleton;

import java.util.Random;

public class Singleton2 {
    private static Singleton2 singleton2;
    private int valor;

    private Singleton2() {
        valor = new Random().nextInt(10);
    }

    public static Singleton2 getInstance() {
        if (singleton2 == null)
            singleton2 = new  Singleton2();
        return singleton2;
    }

    public int getValor() {
        return valor;
    }
}
