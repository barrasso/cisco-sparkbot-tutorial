import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;


public class PostgresqlTest {
   public static void main( String args[] )
     {
       Connection c = null;
       Statement stmt = null;
       try {
       Class.forName("org.postgresql.Driver");
         c = DriverManager
            .getConnection("jdbc:postgresql://localhost:5432/postgres",
            "dbuser", "12345");
         c.setAutoCommit(false);
         System.out.println("Opened database successfully");

         stmt = c.createStatement();
         ResultSet rs = stmt.executeQuery( "SELECT * FROM procedure_codes limit 5;" );
         while ( rs.next() ) {
            String  pc = rs.getString("procedure_code");
            String  l_desc = rs.getString("long_description");
            String s_desc = rs.getString("short_description");
            System.out.println( "Procedure code = " + pc );
            System.out.println( "Long Desc = " + l_desc );
            System.out.println( "Short Desc = " + s_desc );
            System.out.println();
         }
         rs.close();
         stmt.close();
         c.close();
       } catch ( Exception e ) {
         System.err.println( e.getClass().getName()+": "+ e.getMessage() );
         System.exit(0);
       }
       System.out.println("Operation done successfully");
     }
}

