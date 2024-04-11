package bd.dao.daoPerson;

import bd.SetUpConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PersonDAOImpl implements PersonDAO{
    private final Connection connection;
    private Statement statement;
    private PreparedStatement preparedStatement;

    public PersonDAOImpl() throws SQLException, IOException {
        connection = SetUpConnection.getInstance().getConnection();
    }

    @Override
    public List<Person> getPeople() throws SQLException {
        List<Person> people = new ArrayList<>();
        String sql = " SELECT * FROM person ;";
        statement = connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        Person person = null;
        while (resultSet.next()){
            String email = resultSet.getString("email");
            String name  = resultSet.getString("name");
            String code  =  resultSet.getString("code");
            person = new Person(email, name, code);
            people.add(person);
        }
        return people;
    }

    @Override
    public Person getPersonByEmail(String email) {
        return null;
    }

    @Override
    public boolean insertPerson(Person person) {
        return false;
    }

    @Override
    public boolean deletePersonByEmail(String email) {
        return false;
    }

    @Override
    public boolean updatePerson(Person person) {
        return false;
    }
}
