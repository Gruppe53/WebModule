package daointerfaces;


import java.util.List;
import dto.UserDTO;

public interface UserDAO {
	UserDTO getUser(int user_Id) throws DALException;
	List<UserDTO> getUserList() throws DALException;
	void createUser(UserDTO user) throws DALException;
	void updateUser(UserDTO user) throws DALException;
	
}
