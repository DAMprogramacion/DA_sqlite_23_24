package singleton;

import java.sql.Connection;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        Singleton1 s1 = Singleton1.getSingleton1();
        System.out.println(s1);
        Singleton1 s2 = Singleton1.getSingleton1();
        System.out.println(s2);
        for (int i = 0; i < 10; i++) {
            System.out.println(Singleton1.getSingleton1());
        }
        System.out.println("===SINGLETON CON ATRIBUTO===");
        for (int i = 0; i < 10; i++) {
            Singleton2 singleton2 = Singleton2.getInstance();
            int valor = singleton2.getValor();
            System.out.println(valor);
        }
        System.out.println("===SINGLETON CON BD===");
        for (int i = 0; i < 10; i++) {
            try {
                Singleton3 singleton3 = Singleton3.getInstance();
                Connection conexion = singleton3.getConexion();
                System.out.println(conexion);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }
}
