package servlets;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import database.DBAccess;


public class CreateMaterialbatchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CreateMaterialbatchServlet() {
        super();
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		
		String mb_id = req.getParameter("mb_id");
		String m_id = req.getParameter("m_id");
		String amount = req.getParameter("mb_amount");
		
		DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
		
		if((Integer) session.getAttribute("u_level") > 2) //TODO Check user level
			resp.sendRedirect("");
		
		else {
			try{
				con.doSqlUpdate("INSERT INTO matbatch VALUES('" + mb_id +"', '" + m_id +"', '" + amount + "')");
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
