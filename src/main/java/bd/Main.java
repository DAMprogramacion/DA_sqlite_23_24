package bd;

import org.sqlite.SQLiteConfig;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Main {
    public static void main(String[] args) {
        //System.out.println("hola mundo");
      //  String url = "jdbc:sqlite:databases/database.db";
        SQLiteConfig config = new SQLiteConfig();
        config.enforceForeignKeys(true);
        Properties properties = new Properties();
        InputStream input  = ClassLoader.getSystemClassLoader().
                getResourceAsStream("config.properties");
        String driver = null, db = null;
        try {
            properties.load(input);
            driver = properties.getProperty("DRIVER");
            db = properties.getProperty("DB");
        } catch (IOException e) {
            throw new RuntimeException(e);
        } finally {
            if (input != null) {
                try {
                    input.close();
                } catch (IOException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        String url = driver + ":" + db;
        try (
             Connection conexion1 = DriverManager.getConnection(url, config.toProperties());
             Connection conexion2 = DriverManager.getConnection(url);
             Connection conexion3 = DriverManager.getConnection(url);
             Connection conexion4 = DriverManager.getConnection(url)) {
            System.out.println("Conectado...");
            System.out.println(conexion1);
            System.out.println(conexion2);
            System.out.println(conexion3);
            System.out.println(conexion4);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
