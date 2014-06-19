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

public class EditMaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditMaterialServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			String m_id = req.getParameter("m_id");

			DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
			
			try {
				ResultSet rs = con.doSqlQuery("SELECT * FROM materials WHERE m_id = " + m_id);
				
				while(rs.next())
					resp.getWriter().write(rs.getInt("m_id")+"||"+rs.getString("m_name")+"||"+rs.getString("supplier"));
				
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
		
		String m_id = req.getParameter("m_id");
		String m_name = req.getParameter("m_name");
		String supplier = req.getParameter("supplier");
		
		String[] strs = {m_name};
		String[] patterns = {"([a-zA-Z]+[^0-9]*)"};
		
		System.out.println("1");
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			System.out.println("2");
			
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
				
				System.out.println("3");
				
				try {
					int rs = -1;

					rs = con.doSqlUpdate("UPDATE materials SET m_name = '"+m_name+"', supplier = "+supplier+" WHERE m_id = " + m_id);
					
					if(rs > 0)
						resp.getWriter().write("Råvaren med id " + m_id + " er blevet opdateret, med de nye informationer.");
					else if(rs != -1)
						resp.getWriter().write("Kunne ikke kontakte databasen, eller der var en fejl ved opdateringen af data - prøv igen. Fortsætter fejlen, kontakt en voksen.");
					else
						resp.getWriter().write("Ukendt fejl opstod. Prøv igen, eller kontakt en voksen.");
					
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
