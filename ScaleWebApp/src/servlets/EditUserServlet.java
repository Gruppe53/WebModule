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

public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditUserServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		if((Integer) session.getAttribute("u_level") > 1)
			resp.sendRedirect("");
		
		else {
			String u_id = req.getParameter("u_id");

			DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
			
			try {
				ResultSet rs = con.doSqlQuery("SELECT * FROM user WHERE u_id = " + u_id);
				
				while(rs.next())
					resp.getWriter().write(rs.getInt("u_id")+"||"+rs.getString("u_name")+"||"+rs.getString("u_cpr")+"||"+rs.getInt("u_level"));
				
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		String u_id = req.getParameter("u_id");
		String u_name = req.getParameter("u_name");
		String u_cpr = req.getParameter("u_cpr");
		String u_level = req.getParameter("u_level");
		
		System.out.println(u_id);
		System.out.println(u_name);
		System.out.println(u_cpr);
		System.out.println(u_level);
		
		String[] strs = {u_id, u_name, u_cpr};
		String[] patterns = {
				"\\b\\d{8}\\b",
				"([a-zA-Z]+[^0-9]*)",
				"(0[1-9]|[1-2][0-9]|3[0-1])[.\\-/]?(0[1-9]|1[0-2])[.\\-/]?([0-9]{2})([0-9]{4})"
		};
		
		if((Integer) session.getAttribute("u_level") > 1)
			resp.sendRedirect("");
		
		else {
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
				
				try {
					int rs = -1;
					
					
					rs = con.doSqlUpdate("UPDATE user SET u_name = '"+u_name+"', u_cpr = '"+u_cpr+"', u_level = "+u_level+" WHERE u_id = " + u_id);
					
					if(rs > 0)
						resp.getWriter().write("Brugeren er med id " + u_id + " er blevet opdateret, med de nye informationer.");
					else if(rs != -1)
						resp.getWriter().write("Kunne ikke kontakte databasen, eller der var en fejl ved opdateringen af data - prøv igen. Fortsætter fejlen, kontakt en voksen.");
					
				} catch (SQLException e) {
					e.printStackTrace();
					resp.getWriter().write("Kunne ikke kontakte databasen, eller der var en fejl ved opdateringen af data - prøv igen. Fortsætter fejlen, kontakt en voksen.");
				} catch (Exception e) {
					e.printStackTrace();
					resp.getWriter().write("Kritisk programfejl. Kontakt en voksen.");
				}
			}
			else {
				resp.getWriter().write("Fejl i data, prøv igen.");
			}
		}
	}
	
	private boolean checkVals(String[] strs, String[] patterns) {
		for(int i = 0; i < strs.length; i++)
			if(!(strs[i].matches(patterns[i])))
				return false;
		
		return true;
	}
}
