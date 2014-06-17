package servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBAccess;

public class CreatePrescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreatePrescriptionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pre_id = req.getParameter("pre_id");
		String pre_name = req.getParameter("pre_name");
		String[] components = req.getParameterValues("components[]");
		
		DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
		
		try {
			int rs = con.doSqlUpdate("INSERT INTO prescription VALUES(" + pre_id + ", '" + pre_name + "')");
			if(rs > 0) {
				for(String comp : components) {
					rs = con.doSqlUpdate("INSERT INTO precomponent VALUES("+ pre_id + ", " + comp + ", 0, 0)");
					
					if(rs > 0)
						continue;
				}
			}
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

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
