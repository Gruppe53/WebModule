package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import database.DBAccess;

public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public DeleteServlet() {
        super();
    }
    
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String id = req.getParameter("id");
		String to = req.getParameter("to");
		
		DBAccess con = new DBAccess();
		int result;
		
		try {
			if(to.equals("d")) {
				result = con.doSqlUpdate("UPDATE user SET u_active = 0 WHERE u_id = " + id);
				
				if(result > 0)
					resp.getWriter().write("Satte brugeren med id " + id + " til at være inaktiv.");
				else
					resp.getWriter().write("Der skete en fejl ved ændring af brugerens aktivitetsstatus.");
			}
			else {
				result = con.doSqlUpdate("UPDATE user SET u_active = 1 WHERE u_id = " + id);
				
				if(result > 0)
					resp.getWriter().write("Satte brugeren med id " + id + " til at være aktiv.");
				else
					resp.getWriter().write("Der skete en fejl ved ændring af brugerens aktivitetsstatus.");
			}
		} catch (SQLException e) {
			resp.getWriter().write("Kunne ikke kontakte databasen, eller der skete en fejl ved forespørgslen.");
			e.printStackTrace();
		} catch (Exception e) {
			resp.getWriter().write("Kritisk programfejl. Kontakt en voksen.");
			e.printStackTrace();
		}
	}

}
