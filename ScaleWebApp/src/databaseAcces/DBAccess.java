package databaseAcces;

import java.sql.*;

public class DBAccess {
	private Connection connect					= null;
	private Statement statement					= null;
	private PreparedStatement preparedStatement	= null;
	private ResultSet resultSet					= null;
	
	private String DBHost						= "72.13.93.206";
	private int DBPort							= 3307;
	private String DBDatabase					= "gruppe55";
	private String DBUserName					= "gruppe55";
	private String DBPassword					= "55gruppe";
	
	public ResultSet doSqlQuery(String query) throws Exception, SQLException {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			// Template: jdbc:mysql://host/database?user=yourUserName&password=yourPassword
			// Port?... dno
			connect = DriverManager.getConnection(
					"jdbc:mysql://"
					+ DBHost + "/"
					+ DBDatabase
					+ "?user="+ DBUserName
					+ "&password=" + DBPassword
			);
			
			statement = connect.createStatement();
			resultSet = statement.executeQuery("SELECT * FROM user");

			return resultSet;
		}
		catch (Exception e) {
			throw e;
		}
		finally {
			resultSet.close();
			statement.close();
			connect.close();
		}
	}
}