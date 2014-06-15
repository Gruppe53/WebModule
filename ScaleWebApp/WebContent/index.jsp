<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scale Webmodule</title>
    <style type="text/css">
		@import "style/global.css";
	</style>
    <link rel="shortcut icon" href="image/icon.png">
    <script src="script/jquery-2.1.1.min.js"></script>
    <script>
		$(document).ready(function(e) {
			$.ajaxSetup({cache: false});								// Prevent caching - only necessary when rapid editing of pages
			
			var active = "front";										// Default load page
			
			$("#" + active).css("background", "#06F");					// Activate menu link corrosponding to current front page
			$("#" + active).css("color", "#FFF");						// Same...
			$("#container").load(escape(active) + ".jsp");				// Load content corrosponding to the active page
			
			$(".menuBtn").click(function() {							// When we click on menu links
				active = this.getAttribute("id");						// Set new active page
			
				$(".menuBtn").css("background", "#FFF");				// Restyle menu (non-active)
				$(".menuBtn").css("color", "#666");						// Restyle menu (non-active)
				$("#" + active).css("background", "#06F");				// Restyle menu (active)
				$("#" + active).css("color", "#FFF");					// Restyle menu (active)
				
				$('#container').fadeOut('fast', function() {			// Fade current content out
					$.get(												// Create AJAX-object
						escape(active) + ".jsp", 						// Load data from "[active].htm", [active] = active page
						function(data) {
							$("#container").html(data).fadeIn('fast');	// Insert data into the div with #container-id AND fade it in
						}, 
						"html"											// Data type
					);
				});
			});
			
			$(".menuBtn").hover(										// CSS-fix (issues with previous css-styling through jQuery)
				function() {											// When hovering above any tag with ".menuBtn"-class, do...
					$(this).css("background", "#06F");					// New bacgrkound when hovering in
					$(this).css("color", "#FFF");						// New font color when hovering in
				},
				function() {						
					if($(this).attr("id") != active) {					// If current hovering element isn't the active page, do...
						$(this).css("background", "#FFF");				// New bacgrkound color when hovering out
						$(this).css("color", "#666");					// New font color when hovering out
					}
			});
        });
	</script>
</head>
<body>
	<div id="main">
    	<div id="menu">
        	<h1>navigation</h1>
        	<div id="front" class="menuBtn">front</div>
            <div id="users" class="menuBtn">brugere</div>
            <div id="materials" class="menuBtn">råvarer</div>
            <div id="prescriptions" class="menuBtn">recepter</div>
            <div id="materialbatches" class="menuBtn">råvarebatches</div>
            <div id="productbatches" class="menuBtn">produktbatches</div>
        </div>
        <div id="content">
        	<%
				Class.forName("com.mysql.jdbc.Driver").newInstance();
				Connection con = DriverManager.getConnection("jdbc:mysql://72.13.93.206:3307/gruppe55", "gruppe55", "55gruppe");
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("SELECT * FROM user");
			
				try {
					while(rs.next()) {
						%>
							u_name: <%= rs.getString("u_name") %>, u_level: <%= rs.getInt("u_level") %>
						<%
					}
				}
				catch (SQLException e) {
					e.printStackTrace();
				}
				finally {
					rs.close();
					stmt.close();
					con.close();
				}
	        %>
            <div id="container"></div>
        </div>
    </div>
</body>
</html>