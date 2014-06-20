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

public class EditPrescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public EditPrescriptionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			String pre_id = req.getParameter("pre_id");

			DBAccess con = new DBAccess();
			
			try {
				ResultSet rs = con.doSqlQuery("SELECT * FROM productbatch WHERE pre_id = " + pre_id);
				if (!rs.isBeforeFirst()) {    
					resp.getWriter().write("Recepten er blevet brugt til at oprette en produktbatch, og kan derfor ikke redigeres."); 
				}
				else {
					rs = con.doSqlQuery("SELECT * FROM prescription WHERE pre_id = " + pre_id);
					ResultSet cp = con.doSqlQuery("SELECT * FROM precomponent NATURAL JOIN materials WHERE pre_id = " + pre_id);
					
					String comps = "";
					int j = 0;
					
					while(cp.next()) {
						if(j == 0)
							comps += cp.getInt("m_id") + "--" + cp.getString("m_name") + "--" + cp.getDouble("netto") + "--" + cp.getDouble("tolerance");
						else
							comps += "||" + cp.getInt("m_id") + "--" + cp.getString("m_name") + "--" + cp.getDouble("netto") + "--" + cp.getDouble("tolerance");
						
						j++;
					}
					
					while(rs.next())
						resp.getWriter().write(rs.getInt("pre_id")+"||"+rs.getString("pre_name")+"||"+comps);
				}
				
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
		
		String pre_id = req.getParameter("pre_id");
		String pre_name = req.getParameter("pre_name");
		String[] components = req.getParameterValues("components[]");
		String[] nettos = req.getParameterValues("nettos[]");
		String[] tolerance = req.getParameterValues("tolerance[]");
		
		String[] strs = {pre_name};
		String[] patterns = {"([a-zA-Z]+[^0-9]*)"};
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess();
				
				try {
					int rs = -1;

					rs = con.doSqlUpdate("UPDATE prescription SET pre_name = '"+pre_name+"' WHERE pre_id = " + pre_id);
					
					if(rs > 0)
						resp.getWriter().write("Recepten med id " + pre_id + " er blevet opdateret, med de nye informationer.");
					else if(rs != -1)
						resp.getWriter().write("Kunne ikke kontakte databasen, eller der var en fejl ved opdateringen af data - prøv igen. Fortsætter fejlen, kontakt en voksen.");
					else
						resp.getWriter().write("Ukendt fejl opstod. Prøv igen, eller kontakt en voksen.");
					
					rs = con.doSqlUpdate("DELETE FROM precomponent WHERE pre_id = " + pre_id);
					
					if(rs > 0)
						for(int i = 0; i < components.length; i++) {
							rs = con.doSqlUpdate("INSERT INTO precomponent VALUES("+pre_id+", "+components[i]+", "+nettos[i]+", "+tolerance[i]+")");
							
							if(rs > 0)
								continue;
						}
					
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
