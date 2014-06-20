package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAccess;

public class CreateMaterialServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateMaterialServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			resp.setContentType("text/plain");
			resp.setCharacterEncoding("UTF-8");
			
			String m_id = req.getParameter("m_id");
			String m_name = req.getParameter("m_name");
			String s_name = req.getParameter("s_name");
			
			String[] strs = {m_id, m_name, s_name};
			String[] patterns = {
					"\\b\\d{8}\\b",
					"([a-zA-Z]+[^0-9]*)",
					"([a-zA-Z]+[^0-9]*)"
			};
			
			if(checkVals(strs, patterns)) {
				DBAccess con = new DBAccess();
				
				try {
					int rs = con.doSqlUpdate("INSERT INTO materials VALUES (" + m_id + ",'" + m_name + "','" + s_name + "')");
					
					if(rs > 0) 
						resp.getWriter().write("Oprettede råvare med navnet " + m_name + " og id " + m_id + ".");
					else 
						resp.getWriter().write("Kunne ikke oprette råvaren " + m_name + " med id " + m_id + ". Kontroller at råvaren eller id ikke allerede eksisterer.");
				} catch (SQLException e) {
					resp.getWriter().write("Kunne ikke kontakte databasen, eller der skete en fejl ved indsættelse af data.");
					e.printStackTrace();
				} catch (Exception e) {
					resp.getWriter().write("Kritisk programfejl. Kontakt en voksen.");
					e.printStackTrace();
				}
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	
	private boolean checkVals(String[] strs, String[] patterns) {
		if(strs.length == 0 || patterns.length == 0)
			return false;
		
		for(int i = 0; i < strs.length; i++) 
			try {
				if(!(strs[i].matches(patterns[i])))
				return false;
			} catch (Exception e) {
				e.printStackTrace();
			}
		
		return true;
	}
}
