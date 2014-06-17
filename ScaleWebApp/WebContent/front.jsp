<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<h1>front</h1>
<%
	if((Integer) session.getAttribute("u_level") < 5) {
		out.print("<p>Velkommen til Scale Webmodule, ");
		out.print((String) session.getAttribute("u_name"));
		out.print(".</p>");
	}
	else
		out.println("<p>Velkommen til Scale Webmodule.</p>");

	if((Integer) session.getAttribute("u_level") >= 5) {
		%>
			<script>
				$(document).ready(function(e) {
					$.get("login.jsp",function(data) {
						$("#loginBox").html(data).fadeIn("fast");
					},"html");
				});
			</script>
		<%
	}
	else {
		%>
		<p>BrugerID: <%= (Integer) session.getAttribute("u_id") %></p>
		<p>Niveau: <%= (Integer) session.getAttribute("u_level") %></p>
		<%
	}
%>
<div id="loginBox"></div>