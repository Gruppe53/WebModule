package dto;

public class UserDTO {
		
	int user_Id;
	String user_Ini;
	String user_Name;
	String user_Cpr;
	String password;
	int user_Level;

public UserDTO(int user_Id, String user_Ini, String user_Name, String user_Cpr, String password, int user_Level){
	this.user_Id = user_Id;
	this.user_Ini = user_Ini;
	this.user_Name = user_Name;
	this.user_Cpr = user_Cpr;
	this.password = password;
	this.user_Level = user_Level;
}

public int getUser_Id() { return user_Id; }
public void setUser_Id(int user_Id) { this.user_Id = user_Id; }

public String getUser_Ini() { return user_Ini; }
public void setUser_Ini(String user_Ini) { this.user_Ini = user_Ini; }

public String getUser_Name() { return user_Name; }
public void setUser_Name(String user_Name) { this.user_Name = user_Name; }

public String getUser_Cpr() { return user_Cpr; }
public void setUser_Cpr(String user_Cpr) { this.user_Cpr = user_Cpr; }

public String getPassword() { return password; }
public void setPassword(String password) {this.password = password; }

public int getUser_Level() { return user_Level; }
public void setUser_Level(int user_Level) { this.user_Level = user_Level; }

}