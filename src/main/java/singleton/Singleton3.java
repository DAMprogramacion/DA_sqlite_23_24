package singleton;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Singleton3 {
    private static Singleton3 singleton3;
    private Connection conexion;

    private Singleton3() throws SQLException {
        conexion = DriverManager.
                getConnection("jdbc:sqlite:databases/database.db");
    }

    public static Singleton3 getInstance() throws SQLException {
        if (singleton3 == null)
            singleton3 = new Singleton3();
        return singleton3;
    }

    public Connection getConexion() {
        return conexion;
    }
}
