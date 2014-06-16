<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	$("form").on("change", "select[name*='component']", function(e) {
		if($(this).closest("tr").prevAll().length == $(this).closest("tr").siblings().length) {
			var nextComponentNumber = parseInt($(this).attr("name").match(/[0-9]+/), 10) + 1;
			
			var newSelect = "<tr>"
								+ "<td>"
									+ "<select name=\"component" + nextComponentNumber + "\">"
										+ "<option selected=\"selected\" disabled=\"disabled\">Komponent...</option>"
										+ "<option value=\"5434sa\">Salt (5434sa)</option>"
										+ "<option value=\"2154pa\">Paracetamol (2154pa)</option>"
										+ "<option value=\"9885ac\">Acetylsalicylsyre (9885ac)</option>"
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
	
</script>
<h1>råvarer</h1>
<% //------------------------------------------------------- Bækhøj input start -------------------------------- %>
<div title="materialCreate" class="actionBtn" style ="width: 120px">opret råvare</div>
<div style="clear: both;"></div>
<div id="materialList">
	<h2>råvarer</h2>
	<table>
		<tr>
			<td><strong>id</strong></td>
			<td><strong>navn</strong></td>
			<td><strong>leverandør</strong></td>
			<td style="width: 6%;"></td>
		</tr>
		<%
			DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
			ResultSet rs = con.doSqlQuery("SELECT * FROM material");
	
			try {
				int i = 0;
				
				while(rs.next()) {
					if(i % 2 == 0) {
						%>
						<tr class="tableHover">
							<td><%= rs.getInt("m_id") %>		</td>
							<td><%= rs.getString("m_name") %>	</td>
							<td><%= rs.getString("supplier") %>	</td>
							<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
						</tr>
						<%
					}
					else {
						%>
						<tr>
							<td><%= rs.getInt("m_id") %>		</td>
							<td><%= rs.getString("m_name") %>	</td>
							<td><%= rs.getString("supplier") %>	</td>
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
			
			
		%>
		
	
	
	
	</table>
</div>
<% //------------------------------------------------------- Bækhøj input slut -------------------------------- %>
<div class="actionBtn" style="width: 120px">opret råvare</div>
<div style="clear: both;"></div>
<div id="materialList">
	<h2>råvarer</h2>
	<table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>leverandør</strong></td>
            <td style="width: 6%"></td>
        </tr>
        <%
       		rs = con.doSqlQuery("SELECT * FROM materials");
		
			try {
				int i = 0;
				
				while(rs.next()) {
					if(i % 2 == 0) {
						%>
						<tr bgcolor="#dfecff">
				        	<td><%= rs.getInt("m_id") %></td>
				            <td><%= rs.getString("m_name") %></td>
				            <td><%= rs.getString("supplier") %></td>
				            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
				        </tr>
						<%
					}
					else {
						%>
						<tr>
				        	<td><%= rs.getInt("m_id") %></td>
				            <td><%= rs.getString("m_name") %></td>
				            <td><%= rs.getString("supplier") %></td>
				            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
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
<div id="materialCreate">
	<h2>opret råvare</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="mid">Råvare id</label>
                </td>
                <td>
                	<input id="mid" name="mid" type="text" maxlength="8" placeholder="1234xx" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="mname">Navn</label>
                </td>
                <td>
          			<input id="mname" name="mname" type="text" maxlength="100" placeholder="Råvarenavn..." />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="supplier">Leverandør</label>
                </td>
                <td>
                    <select name="supplier">
                        <option selected="selected" disabled="disabled">Leverandør...</option>
                        <option value="Alternova">Alternova</option>
                        <option value="Bents Biokemi">Bents Biokemi</option>
                        <option value="Takeda Pharma">Takeda Pharma</option>
                        <option value="GlaxoSmithKline Consumer Healthcare">GlaxoSmithKline Consumer Healthcare)</option>
                        <option value="GC Rieber Salt A/S">GC Rieber Salt A/S</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createMaterialSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="materialEdit">
	<h2>rediger råvare</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="mid">Råvare id</label>
                </td>
                <td>
                	<input id="mid" name="mid" type="text" maxlength="8" value="5434sa" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="mname">Navn</label>
                </td>
                <td>
          			<input id="mname" name="mname" type="text" maxlength="100" value="Salt" />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="supplier">Leverandør</label>
                </td>
                <td>
                    <select name="supplier">
                        <option disabled="disabled">Leverandør...</option>
                        <option value="Alternova">Alternova</option>
                        <option value="Bents Biokemi">Bents Biokemi</option>
                        <option value="Takeda Pharma">Takeda Pharma</option>
                        <option value="GlaxoSmithKline Consumer Healthcare">GlaxoSmithKline Consumer Healthcare)</option>
                        <option selected="selected" value="GC Rieber Salt A/S">GC Rieber Salt A/S</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createMaterialSub" value="Opdater" /></td>
            </tr>
        </table>
	</form>
</div>