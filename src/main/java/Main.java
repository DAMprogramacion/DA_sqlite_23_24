import bd.SetUpConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

public class Main {
    public static void main(String[] args) {
        try (Connection connection1 = SetUpConnection.getInstance().getConnection();
             Connection connection2 = SetUpConnection.getInstance().getConnection();
             Connection connection3 = SetUpConnection.getInstance().getConnection()) {
            System.out.println(connection1);
            System.out.println(connection2);
            System.out.println(connection3);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
