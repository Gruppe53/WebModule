package daoimpl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;

import DBaccess.Connector;


import daointerfaces.UserDAO;
import daointerfaces.DALException;
import dto.UserDTO;


public class MySQLUserDAO implements UserDAO {

	@Override
	public UserDTO getUser(int user_Id) throws DALException {
		ResultSet rs = Connector.doQuery("SELECT * FROM user WHERE user_Id = " + user_Id);
		
		try{
			if (!rs.first()) throw new DALException("User with user_Id = " + user_Id + ". Does not exist");
			return new UserDTO(rs.getInt("user_id"), rs.getString("user_Ini"), rs.getString("user_Name"), rs.getString("user_Cpr"), rs.getString("password"), rs.getInt("user_Level"));
		}
		catch (SQLException e) {throw new DALException(e); }
		// TODO Auto-generated method stub
	}

	@Override
	public List<UserDTO> getUserList() throws DALException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void createUser(UserDTO user) throws DALException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateUser(UserDTO user) throws DALException {
		// TODO Auto-generated method stub
		
	}

}
