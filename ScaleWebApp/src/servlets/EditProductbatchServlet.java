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

public class EditProductbatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditProductbatchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		if((Integer) session.getAttribute("u_level") > 3)
			resp.sendRedirect("");
		
		else {
			String pb_id = req.getParameter("pb_id");

			DBAccess con = new DBAccess();
			
			try {
				ResultSet rs = con.doSqlQuery("SELECT * FROM productbatch WHERE pb_id = " + pb_id + " AND status = 0");
				
				if(!rs.isBeforeFirst())
					resp.getWriter().write("||na||");
				else
					while(rs.next())
						resp.getWriter().write(rs.getInt("pb_id")+"||"+rs.getString("pre_id")+"||"+rs.getInt("status"));
				
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
		
		String pb_id = req.getParameter("pb_id");
		String pre_id = req.getParameter("pre_id");
		String status = req.getParameter("status");
		
		String[] strs = {pre_id, status};
		String[] patterns = {
				"\\b\\d{8}\\b",
				"\\b\\d{1}\\b"
				};
		
		if((Integer) session.getAttribute("u_level") > 3)
			resp.sendRedirect("");
		
		else {
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess();
				
				try {
					int rs = -1;

					rs = con.doSqlUpdate("UPDATE productbatch SET pre_id = "+pre_id+", status = "+status+" WHERE pb_id = " + pb_id);
					
					if(rs > 0)
						resp.getWriter().write("Produktbatchen med id " + pb_id + " er blevet opdateret med recepten "+pre_id+".");
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
