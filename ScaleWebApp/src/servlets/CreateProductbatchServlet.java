package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAccess;


public class CreateProductbatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateProductbatchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String pb_id = req.getParameter("pb_id");
		String pre_id= req.getParameter("pre_id");
		
		DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
		
		if((Integer) session.getAttribute("u_level") > 3)
			resp.sendRedirect("");
		
		else {
			try {
				con.doSqlUpdate("INSERT INTO productbatch VALUES('"+ pb_id + "', '0', '" + pre_id + "')");
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
