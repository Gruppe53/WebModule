package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.*;

public class CreateUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public CreateUserServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		if((Integer) session.getAttribute("u_level") > 1)
			resp.sendRedirect("");
		
		else {
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			
			String u_id = req.getParameter("u_id");
			String u_name = req.getParameter("u_name");
			String u_cpr = req.getParameter("u_cpr");
			String password = req.getParameter("password");
			String passwordrepeat = req.getParameter("passwordrepeat");
			String u_level = req.getParameter("u_level");
			
			String[] strs = {u_id, u_name, u_cpr, password};
			String[] patterns = {
					"\\b\\d{8}\\b",
					"([a-zA-Z]+[^0-9]*)",
					"(0[1-9]|[1-2][0-9]|3[0-1])[.\\-/]?(0[1-9]|1[0-2])[.\\-/]?([0-9]{2})([0-9]{4})",
					"(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
			};
			
			if(checkVals(strs, patterns) && password.equals(passwordrepeat)) {
				DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
				try {
					int rs = con.doSqlUpdate("INSERT INTO user VALUES ('" + u_id + "','" + u_name + "','" + u_cpr + "','" + password + "'," + u_level + ", 1)");
					
					if(rs > 0) 
						resp.getWriter().write("Successfully inserted " + u_name + " with id " + u_id + " into the database.");
					else 
						resp.getWriter().write("Could not insert " + u_name + " with id " + u_id + " into the database.");
				}
				catch (Exception e) {
					e.printStackTrace();
				}
				finally {
					try {
						con.closeSql();
					}
					catch(SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	private boolean checkVals(String[] strs, String[] patterns) {
		for(int i = 0; i < strs.length; i++) 
			if(!(strs[i].matches(patterns[i])))
				return false;
		
		return true;
	}
}