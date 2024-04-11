package bd.dao.daoPerson;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        try {
            PersonDAO personDAO = new PersonDAOImpl();
            List<Person> people =  personDAO.getPeople();
            people.forEach(System.out::println);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
