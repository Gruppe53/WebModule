import java.sql.*;

import database.*;

public class Test {
	private static DBAccess db;
	private static ResultSet test;
	
	public static void main(String[] args) throws SQLException, Exception {
		db = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
		
		System.out.println("--- INSERT ---");
		try {
			int knald = db.doSqlUpdate("INSERT INTO user VALUES(4, 'Malte Magnussen', '1234567893', '2341', 1)");
			
			if(knald > 0)
				System.out.println("Succes");
		}
		catch(SQLException e) {
			System.out.println("Failure");
		}
		
		
		System.out.println("--- SELECT ---");
		test = db.doSqlQuery("SELECT * FROM user");
		
		try {
			while(test.next())
				System.out.println("u_name: " + test.getString("u_name") + ", u_level: " + test.getInt("u_level"));
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			test.close();
			db.closeSql();
		}
	}
}