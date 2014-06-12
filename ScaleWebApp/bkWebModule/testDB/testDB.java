package testDB;

import java.sql.SQLException;

import daoimpl.MySQLUserDAO;
import daointerfaces.DALException;
import DBaccess.Connector;

public class testDB {
	public static void main(String [] args){
	try { new Connector(); }
	catch (InstantiationException e) { e.printStackTrace(); }
	catch (IllegalAccessException e) { e.printStackTrace(); }
	catch (ClassNotFoundException e) { e.printStackTrace(); }
	catch (SQLException e) { e.printStackTrace(); }
	
	
	System.out.println("User with user_Id = 1: ");
	MySQLUserDAO noget = new MySQLUserDAO();
	try{ System.out.println(noget.getUser(1)); }
	catch (DALException e) { System.out.println(e.getMessage()); }
	
}
}
