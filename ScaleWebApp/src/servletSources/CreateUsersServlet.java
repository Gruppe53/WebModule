package servletSources;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CreateUsersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public CreateUsersServlet() {
		super();
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		resp.setContentType("text/plain");
		resp.setCharacterEncoding("UTF-8");
		
		String u_name = req.getParameter("u_name");
		
		System.out.println("Name: " + u_name);
		
		if(!(u_name.isEmpty() || u_name.equals(""))) {
			resp.getWriter().write("Der var sgu hul.");
		}
	}
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		System.out.println("Action: Did post.");
		
		doGet(req, resp);
	}
}