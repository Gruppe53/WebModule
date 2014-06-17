<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 2) {
		out.println("document.location = ''");
	}
	%>
	
	var showDiv;
	
	$(".actionBtn").click(function(e) {
		showDiv = this.getAttribute("title");
		var display = $("#" + showDiv).css("display");
		
		if(display == "none")
			$("#" + showDiv).fadeIn("fast");
		else if(display == "block")
			$("#" + showDiv).fadeOut("fast");
		
		if(showDiv == "userEdit") {
			// TODO
		}
	});
	
	$("form").on("change", "select[name*='component']", function(e) {
		if($(this).closest("tr").prevAll().length == $(this).closest("tr").siblings().length) {
			var newSelect = "<tr>"
								+ "<td>"
									+ "<select name=\"component\">"
									+ "<option value=\"\" disabled=\"disabled\" selected=\"selected\">"
									<%
									DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
						        	ResultSet rs = con.doSqlQuery("SELECT * FROM materials");
									
									try {
										while(rs.next()) {
											%>
											+ "<option value=\"<%= rs.getInt("m_id") %>\"><%= rs.getString("m_name") %> [<%= rs.getInt("m_id") %>]</option>"
											<%
										}
									}
									catch (SQLException e) {
										e.printStackTrace();
									}
									finally {
										rs.close();
										con.closeSql();
									}
									%>
									+ "</select>"
								+ "</td>"
								+ "<td>"
									+ " <span class=\"delComponent\" style=\"cursor: pointer;\">x</span>"
								+ "</td>"
							+ "</tr>";
							
			$(this).closest("tr").after(newSelect);
		}
	});
	
	$("form").on("click", "span[class*='delComponent']", function(e) {
		$(this).closest("tr").remove();
	});
	
	$("input[name='createPrescriptionSub']").click(function(e) {
		var id = $("input[name='pre_id']").val();
		var name = $("input[name='pre_name']").val();
		var comps = $("select[name='component']").val();
		
		$.post(
			"CreatePrescriptionServlet",
			{pre_id:id, pre_name:name, components:comps},
			function(response) {
				$("#container").fadeOut('fast', function() {
					$.get(
						"prescriptions.jsp",
						function(data) {
							$("#container").html(data).fadeIn('fast');
						},
						"html"
					);
				});
				
				if(response.substring(1,1) == "S") {
					$("input[name='pre_id']").val("");
					$("input[name='pre_name']").val("");
					
					var display = $("#" + showDiv).css("display");
					
					if(display == "none")
						$("#" + showDiv).fadeIn("fast");
					else if(display == "block")
						$("#" + showDiv).fadeOut("fast");
					
					$("span#latestMsg").html(response).fadeIn("fast");
				}
				else {
					$("span#latestMsg").html(response).fadeIn("fast");
				}
			},
			"html"
		);
	});
	
</script>
<h1>recepter</h1>
<div title="prescriptionCreate" class="actionBtn" style="width: 120px">opret recept</div>
<div style="clear: both;"></div>
<div id="prescriptionList">
	<h2>recepter</h2>
	<table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>komponenter</strong></td>
            <td style="width: 6%"></td>
        </tr>
        <%
        	rs = con.doSqlQuery("SELECT * FROM prescription");
        	
        	try {
        		int i = 0;
        		
        		while(rs.next()) {
        			if (i % 2 == 0) {
        				%>
        				<tr class="tableHover">
        					<td><%= rs.getInt("pre_id")  %></td>
        					<td><%= rs.getString("pre_name") %></td>
        					<%
        					ResultSet components = con.doSqlQuery("SELECT * FROM precomponent NATURAL JOIN materials WHERE pre_id = " + rs.getInt("pre_id"));
        					String comps = "";
        					int j = 0;
        					
        					while(components.next()) {
        						if(j == 0)
        							comps = components.getString("m_name");
        						else
        							comps += ", " +  components.getString("m_name");
        						
        						j++;
        					}
        					
        					components.close();
        					con.closeSql();
        					%>
        					<td><%= comps %></td>
        					<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        				</tr>
        				<% 
        			}
        			else {
        				%>
        				
        				<tr>
        					<td><%= rs.getInt("pre_id")  %></td>
        					<td><%= rs.getString("pre_name") %></td>
        					<%
        					ResultSet components = con.doSqlQuery("SELECT * FROM precomponent NATURAL JOIN materials WHERE pre_id = " + rs.getInt("pre_id"));
        					String comps = "";
        					int j = 0;
        					
        					while(components.next()) {
        						if(j == 0)
        							comps = components.getString("m_name");
        						else
        							comps += ", " +  components.getString("m_name");
        						
        						j++;
        					}
        					
        					components.close();
        					con.closeSql();
        					%>
        					<td><%= comps %></td>
        					<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        				</tr>
        				<%
        			}
        			
        			i++;
        		}			
        	}
        	catch (SQLException e) {
        		e.printStackTrace();
        	}
        	finally {
        		rs.close();
        		con.closeSql();
        	}
        %>
	</table>
</div>
<div id="prescriptionCreate" style="display: none;">
	<h2>opret recept</h2>
	<form action="" method="post" id="preCreate" name="prescriptionCreate">
        <table>
        	<tr>
            	<td>
                	<label for="pre_id">Recept id</label>
                </td>
                <td>
                	<input id="pre_id" name="pre_id" type="text" maxlength="8" placeholder="12345678" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="pre_name">Navn</label>
                </td>
                <td>
          			<input id="pre_name" name="pre_name" type="text" maxlength="100" placeholder="Receptnavn..." />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="component[0]">Komponenter</label>
                </td>
                <td style="padding: 0px 0px 0px 0px;">
                	<table id="componentsTable" style="border-spacing: 0px;">
                    	<tr>
                            <td>
                                <select name="component">
                                    <option selected="selected" disabled="disabled">Komponent...</option>
                                    <%
									rs = con.doSqlQuery("SELECT m_id, m_name FROM materials");
									
									try {
										while(rs.next()) {
											%>
											<option value="<%= rs.getInt("m_id") %>"><%= rs.getString("m_name") %> [<%= rs.getInt("m_id") %>]</option>
											<%
										}
									}
									catch (SQLException e) {
										e.printStackTrace();
									}
									finally {
										rs.close();
										con.closeSql();
									}
									%>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="button" name="createPrescriptionSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="prescriptionEdit" style="display: none;">
	<h2>rediger recept</h2>
	<form action="" method="post" id="preCreate" name="prescriptionCreate">
        <table>
        	<tr>
            	<td>
                	<label for="mid">Recept id</label>
                </td>
                <td>
                	<input id="mid" name="mid" type="text" maxlength="8" value="54831969" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="rname">Navn</label>
                </td>
                <td>
          			<input id="rname" name="rname" type="text" maxlength="100" value="Salt" />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="component">Komponenter</label>
                </td>
                <td style="padding: 0px 0px 0px 0px;">
                	<table id="componentsTable" style="border-spacing: 0px;">
                    	<tr>
                            <td>
                                <select name="component1">
                                    <option disabled="disabled">Komponent...</option>
                                    <option selected="selected" value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <select name="component2">
                                    <option disabled="disabled">Komponent...</option>
                                    <option value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                    <option selected="selected" value="543534">Chlorid</option>
                                </select>
                            </td>
                            <td><span class="delComponent" style="cursor: pointer"> x</span></td>
                        </tr>
                        <tr>
                            <td>
                                <select name="component3">
                                    <option selected="selected" disabled="disabled">Komponent...</option>
                                    <option value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                </select>
                            </td>
                            <td><span class="delComponent" style="cursor: pointer"> x</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="editPrescriptionSub" value="Opdater" /></td>
            </tr>
        </table>
	</form>
</div>