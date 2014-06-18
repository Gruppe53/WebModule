package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAccess;

public class CreatePrescriptionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CreatePrescriptionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String pre_id = req.getParameter("pre_id");
		String pre_name = req.getParameter("pre_name");
		String[] components = req.getParameterValues("components[]");
		
		DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
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
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}
