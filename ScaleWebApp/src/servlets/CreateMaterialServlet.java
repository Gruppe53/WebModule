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
						resp.getWriter().write("Successfully inserted " + m_name + " with id " + m_id + " into the database.");
					else 
						resp.getWriter().write("Could not insert " + m_name + " with id " + m_id + " into the database.");
				}
				catch (Exception e) {
					e.printStackTrace();
				}
				finally {
					try {
						con.closeSql();
					}
					catch (SQLException e) {
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
		if(strs.length == 0 || patterns.length == 0)
			return false;
		
		for(int i = 0; i < strs.length; i++) 
			if(!(strs[i].matches(patterns[i])))
				return false;
		
		return true;
	}
}
