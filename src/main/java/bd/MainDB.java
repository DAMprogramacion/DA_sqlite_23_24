package bd;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class MainDB {
    public static void main(String[] args) {
        try {
            MobileDB mobileDB = new MobileDB();
            /*Mobile mobile = new Mobile("yyy", "modelYY", 500.3);
            boolean insertSuccess = mobileDB.insertMobile(mobile);
            System.out.printf("Insercción correcta: %B%n", insertSuccess);
            String serial = "xxx2";
            boolean deleteSuccess = mobileDB.deleteMobile(serial);
            System.out.printf("Borrado correcto: %B%n", deleteSuccess);
            String serial = "xxx1dfdfdfdf";
            double price = 600;
            boolean updateSuccess = mobileDB.updateMobilePrice(price, serial);
            System.out.printf("Actualizado precio, correcto: %B%n", updateSuccess);
            List<Mobile> mobiles = mobileDB.getMobiles();
            mobiles.forEach(System.out::println);
            List<Mobile> mobiles = mobileDB.getMobileBySerial("x'  OR '1' = '1");
            mobiles.forEach(System.out::println);*/
            Mobile mobile = mobileDB.getMobileBySerialEnhaced("x'  OR '1' = '1");
            System.out.println(mobile);


        } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
