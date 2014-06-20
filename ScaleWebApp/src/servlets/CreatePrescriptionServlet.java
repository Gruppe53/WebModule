package servlets;

import java.io.IOException;

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
		String[] nettos = req.getParameterValues("nettos[]");
		String[] tolerance = req.getParameterValues("tolerance[]");
		
		String[] strs = {pre_id, pre_name};
		String[] patterns = {
				"\\b\\d{8}\\b",
				"([a-zA-Z]+[^0-9]*)"
				};
		
		DBAccess con = new DBAccess();
		
		if((Integer) session.getAttribute("u_level") > 2)
			resp.sendRedirect("");
		
		else {
			if (checkVals(strs,  patterns)){
			
			
			try {
				int rs = con.doSqlUpdate("INSERT INTO prescription VALUES(" + pre_id + ", '" + pre_name + "')");
				if(rs > 0) {
					for(int i = 0; i < (components.length - 1); i++) {
						rs = con.doSqlUpdate("INSERT INTO precomponent VALUES("+pre_id+", "+components[i]+", "+nettos[i]+", "+tolerance[i]+")");
						
						if(rs > 0)
							continue;
					}
					
					String compsStr = "";
					
					for(int i = 0; i < (components.length - 1); i++)
						if(i == 0)
							compsStr = components[i];
						else
							compsStr += ", " + components[i];
						
					
					resp.getWriter().write("Oprettede en recept med id "+pre_id+" og navn "+pre_name+", som indeholder komponenterne "+compsStr);
				}
			}
			catch (Exception e) {
				e.printStackTrace();
			}
			}
		}
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}
	private boolean checkVals(String[] strs, String[] patterns) {
		for(int i = 0; i < strs.length; i++)
			if(!(strs[i].matches(patterns[i])))
				return false;
		
		return true;
	}

}
