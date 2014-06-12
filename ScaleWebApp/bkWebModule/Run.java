import java.sql.SQLException;

import daointerfaces.DALException;
import DBaccess.Connector;

public class Run {
	
	public static void main(String [] args) throws DALException {
		Connector conn = null;
		try { new Connector(); }
		catch (InstantiationException e) { e.printStackTrace(); }
		catch (IllegalAccessException e) { e.printStackTrace(); }
		catch (ClassNotFoundException e) { e.printStackTrace(); }
		catch (SQLException e) { e.printStackTrace(); }
		
		
		
		System.out.println("Test1, print all users: ");
		
		try { System.out.println(conn.doQuery("SELECT * FROM user")); }
		finally {
			
		}
	}
	
}
