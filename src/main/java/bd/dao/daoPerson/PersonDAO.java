package bd.dao.daoPerson;

import java.sql.SQLException;
import java.util.List;

public interface PersonDAO {
    //CRUD
    List<Person> getPeople() throws SQLException;
    Person getPersonByEmail(String email);
    boolean insertPerson(Person person);
    boolean deletePersonByEmail(String email);
    boolean updatePerson(Person person);
}
