<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<h1>front</h1>
<p>Velkommen til Scale Webmodule.</p>
<div id="loginBox"></div>
<%
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
%>