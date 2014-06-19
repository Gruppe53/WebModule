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

public class EditMaterialbatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditMaterialbatchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		if((Integer) session.getAttribute("u_level") > 3)
			resp.sendRedirect("");
		
		else {
			String mb_id = req.getParameter("mb_id");

			DBAccess con = new DBAccess();
			
			try {
				ResultSet rs = con.doSqlQuery("SELECT * FROM matbatch WHERE mb_id = " + mb_id);
				
				while(rs.next())
					resp.getWriter().write(rs.getInt("mb_id")+"||"+rs.getString("m_id")+"||"+rs.getDouble("amount"));
				
			} catch (SQLException e) {
				e.printStackTrace();
				resp.getWriter().write("Kunne ikke komme i kontakt med databasen.");
			} catch (Exception e) {
				e.printStackTrace();
				resp.getWriter().write("Kritisk programfejl, kontakt en voksen.");
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		String mb_id = req.getParameter("mb_id");
		String m_id = req.getParameter("m_id");
		String amount = req.getParameter("amount");
		
		String[] strs = {m_id, amount};
		String[] patterns = {"\\b\\d{8}\\b","(?:\\d*\\.)?\\d+"};
		
		if((Integer) session.getAttribute("u_level") > 3)
			resp.sendRedirect("");
		
		else {
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess();
				
				try {
					int rs = -1;

					rs = con.doSqlUpdate("UPDATE matbatch SET m_id = "+m_id+", amount = "+amount+" WHERE mb_id = " + mb_id);
					
					if(rs > 0)
						resp.getWriter().write("Råvarebatchen med id " + mb_id + " er blevet opdateret med de nye informationer.");
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
