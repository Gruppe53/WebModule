package servlets;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAccess;

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String u_id = req.getParameter("username");
		String password = req.getParameter("password");
		
		DBAccess con = null;
		ResultSet rs = null;
		
		try {
			con = new DBAccess();
			rs = con.doSqlQuery("SELECT * FROM user WHERE u_id = " + u_id);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			while(rs.next()) {
				if(password.equals(rs.getString("password"))) {
					HttpSession session = req.getSession();
					
					session.setAttribute("u_id", new Integer(rs.getInt("u_id")));
					session.setAttribute("u_name", new String(rs.getString("u_name")));
					session.setAttribute("u_level", new Integer(rs.getInt("u_level")));
					
					session.setMaxInactiveInterval(20*60);
					
					resp.sendRedirect("");
				}
				else {
					System.out.println("Failure.");
					resp.sendRedirect("");
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		finally {
			try {
				rs.close();
				con.closeSql();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
}
