<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 2) {
		out.println("document.location = ''");
	}
	
	DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
	ResultSet rs = null;
	%>
	
	var showDiv;
	
	$(".actionBtn").click(function(e) {
		showDiv = this.getAttribute("title");
		var display = $("#" + showDiv).css("display");
		
		if(display == "none")
			$("#" + showDiv).fadeIn("fast");
		else if(display == "block")
			$("#" + showDiv).fadeOut("fast");
	});
	
	$("form").on("change", "select[name='component']", function(e) {
		if($(this).closest("tr").prevAll().length == $(this).closest("tr").siblings().length) {
			var newSelect = "<tr>"
								+ "<td>"
									+ "<select name=\"component\">"
									+ "<option disabled=\"disabled\" selected=\"selected\">Komponent...</option>"
									<%
									rs = con.doSqlQuery("SELECT * FROM materials");
									
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
								+ "<td><input id=\"netto\" name=\"netto\" type=\"text\" placeholder=\"1234\" /></td>"
								+ "<td><input id=\"tolerance\" name=\"tolerance\" type=\"text\" placeholder=\"12.34\" /></td>"
								+ "<td>"
									+ " <span class=\"delComponent\" style=\"cursor: pointer;\">x</span>"
								+ "</td>"
							+ "</tr>";
							
			$(this).closest("tr").after(newSelect);
		}
	});
	
	$("img[name*='editPrescriptionId']").click(function(e) {
		var id = this.getAttribute("name").substring(18);
		
		$.get(
			"EditPrescriptionServlet",
			{pre_id:id},
			function(response) {
				var presInfo = response.split("||");
				var compsInfo = [];
				
				for(var i = 2; i < presInfo.length; i++) {
					var p = presInfo[i].split("--");
					
					for(var j = 0; j < p.length; j++)
						compsInfo.push(p[j]);
				}
				
				$("form#prescriptionEditForm input[name='pre_id']").val(presInfo[0]);
				$("form#prescriptionEditForm input[name='pre_name']").val(presInfo[1]);
				
				var newSelectSecond = "<tr>"
					+ "<td>"
						+ "<select name=\"component\">"
						+ "<option disabled=\"disabled\" selected=\"selected\">Komponent...</option>"
						<%
						rs = con.doSqlQuery("SELECT * FROM materials");
						
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
					+ "<td><input id=\"netto\" name=\"netto\" type=\"text\" /></td>"
					+ "<td><input id=\"tolerance\" name=\"tolerance\" type=\"text\" /></td>"
					+ "<td>"
						+ " <span class=\"delComponent\" style=\"cursor: pointer;\">x</span>"
					+ "</td>"
				+ "</tr>";
				
				var newSelectFirst = "<tr>"
					+ "<td>"
						+ "<select name=\"component\">"
						+ "<option disabled=\"disabled\" selected=\"selected\">Komponent...</option>"
						<%
						rs = con.doSqlQuery("SELECT * FROM materials");
						
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
					+ "<td><input id=\"netto\" name=\"netto\" type=\"text\" /></td>"
					+ "<td><input id=\"tolerance\" name=\"tolerance\" type=\"text\" /></td>"
					+ "<td>"
					+ "</td>"
				+ "</tr>";
				
				var insertSelects = "";
				
				for(var i = 0; i < (compsInfo.length/4); i++) {
					if(i == 0)
						insertSelects += newSelectFirst;
					else
						insertSelects += newSelectSecond;
				}
				
				$("form#prescriptionEditForm table#componentsTable").html(insertSelects);
				
				var i = 0;
				
				$("form#prescriptionEditForm select[name='component']").each(function(index) {
					$(this).val(compsInfo[i]);
					i = i + 4;
				});
				
				var i = 2;
				
				$("form#prescriptionEditForm input[name='netto']").each(function(index) {
					$(this).val(compsInfo[i]);
					i = i + 4;
				});
				
				var i = 3;
				
				$("form#prescriptionEditForm input[name='tolerance']").each(function(index) {
					$(this).val(compsInfo[i]);
					i = i + 4;
				});
				
				$("div#prescriptionEdit").fadeIn("fast");
			},
			"html"
		);
	});
	
	$("form").on("click", "span[class='delComponent']", function(e) {
		$(this).closest("tr").remove();
	});
	
	$("input[name='createPrescriptionSub']").click(function(e) {
		var id = $("input[name='pre_id']").val();
		var name = $("input[name='pre_name']").val();
		var comps = [];
		var nets = [];
		var tols = [];
		
		$("select[name='component']").each(function(index) {
			if($(this).val() != null || $(this).val() != "")
				comps.push($(this).val());
		});
		
		$("input[name='netto']").each(function(index) {
			if($(this).val() != null || $(this).val() != "")
				nets.push($(this).val());
		});
		
		$("input[name='tolerance']").each(function(index) {
			if($(this).val() != null || $(this).val() != "")
				tols.push($(this).val());
		});
		
		$.post(
			"CreatePrescriptionServlet",
			{pre_id:id, pre_name:name, 'components[]':comps, 'nettos[]':nets, 'tolerance[]':tols},
			function(response) {
				alert(response);
				
				$("#container").fadeOut('fast', function() {
					$.get(
						"prescriptions.jsp",
						function(data) {
							$("#container").html(data).fadeIn('fast');
						},
						"html"
					);
				});
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
        	ResultSet components = con.doSqlQuery("SELECT * FROM precomponent NATURAL JOIN materials");
        	
        	try {
        		int i = 0;
        		
        		while(rs.next()) {
        			components.first();
        			
        			if (i % 2 == 0) {
        				%>
        				<tr class="tableHover">
        					<td><%= rs.getInt("pre_id")  %></td>
        					<td><%= rs.getString("pre_name") %></td>
        					<%
        					String comps = "";
        					int j = 0;
        					
        					while(components.next()) {
        						if(rs.getInt("pre_id") == components.getInt("pre_id")) {
	        						if(j == 0)
	        							comps = components.getString("m_name") + " (" + components.getDouble("netto") + " g)";
	        						else
	        							comps += ", " +  components.getString("m_name") + " (" + components.getDouble("netto") + " g)";
	        						
	        						j++;
        						}
        					}
        					%>
        					<td><%= comps %></td>
        					<td style="text-align: center;"><img alt="editPrescriptionId<%= rs.getInt("pre_id") %>" name="editPrescriptionId<%= rs.getInt("pre_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></td>
        				</tr>
        				<% 
        			}
        			else {
        				%>
        				
        				<tr>
        					<td><%= rs.getInt("pre_id")  %></td>
        					<td><%= rs.getString("pre_name") %></td>
        					<%
        					String comps = "";
        					int j = 0;
        					
        					while(components.next()) {
        						if(rs.getInt("pre_id") == components.getInt("pre_id")) {
	        						if(j == 0)
	        							comps = components.getString("m_name") + " (" + components.getDouble("netto") + " g)";
	        						else
	        							comps += ", " +  components.getString("m_name") + " (" + components.getDouble("netto") + " g)";
	        						
	        						j++;
        						}
        					}
        					%>
        					<td><%= comps %></td>
        					<td style="text-align: center;"><img alt="editPrescriptionId<%= rs.getInt("pre_id") %>" name="editPrescriptionId<%= rs.getInt("pre_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></td>
        				</tr>
        				<%
        			}
        			
        			i++;
        		}
        		
        		components.close();
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
                            <td><input id="netto" name="netto" type="text" placeholder="1234"/></td>
							<td><input id="tolerance" name="tolerance" type="text" placeholder="12.34"/></td>
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
	<form method="post" id="prescriptionEditForm">
        <table>
        	<tr>
            	<td>
                	<label for="pre_id">Recept id</label>
                </td>
                <td>
                	<input id="pre_id" name="pre_id" type="text" maxlength="8" value="" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="pre_name">Receptnavn</label>
                </td>
                <td>
          			<input id="pre_name" name="pre_name" type="text" maxlength="100" value="" />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="component">Komponenter</label>
                </td>
                <td style="padding: 0px 0px 0px 0px;">
                	<table id="componentsTable" style="border-spacing: 0px;">
                		
                    </table>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Annuller" /><input type="button" name="editPrescriptionSub" value="Opdater" /></td>
            </tr>
        </table>
	</form>
</div>