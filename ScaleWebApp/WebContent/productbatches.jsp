<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 3) {
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
		
		if(showDiv == "productBatchEdit") {
			// TODO
		}
	});
	
	$("input[name='createProductBatchSub']").click(function(e) {
		alert("y0");
	});
</script>
<h1>produktbatches</h1>
<div title="productBatchCreate" class="actionBtn" style="width: 160px">opret produktbatch</div>
<div style ="clear: both;"></div>
<div id="productBatchList">
	<h2>Productbatches</h2>
	<table>
		<tr>
			<td><strong>id</strong></td>
			<td><strong>status</strong></td>
			<td><strong>recept id</strong></td>
			<td style="width: 6%;"></td>
		</tr>
		<%
			DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
			ResultSet rs = con.doSqlQuery("SELECT * FROM productbatch");
			
			try {
				int i = 0;
				
				while(rs.next()) {
					
					int statusInt = rs.getInt("status");
					String statusStr = null;
					
					if (statusInt == 0) statusStr = "Oprettet";
					else if (statusInt == 1) statusStr = "Under Produktion";
					else statusStr = "Afsluttet";
					
					if (i % 2 == 0) {
						%>
						<tr class="tableHover">
							<td><%= rs.getInt("pb_id") %>	</td>
							<td><%= statusStr %>	</td>
							<td><%= rs.getInt("pre_id") %>	</td>
							<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
						</tr>
						<%
					}
					else {
						%>
						<tr>
							<td><%= rs.getInt("pb_id") %>	</td>
							<td><%= statusStr %>	</td>
							<td><%= rs.getInt("pre_id") %>	</td>
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
<div id="productBatchCreate" style="display: none;">
	<h2>opret produktbatch</h2>
	<form id="productBatchCreateForm" method="post">
        <table>
        	<tr>
            	<td><label for="pb_id">ProduktBatch Id</label></td>
                <td><input id="pb_id" name="pb_id" type="text" maxlength="8" placeholder="12345678" /></td>
				
            </tr>
            <tr>
                <td><label for="pre_id">Vælg recept</label></td>
                <td>
                    <select id="pre_id" name="pre_id">
                    	<option selected="selected" disabled="disabled">Recept</option>
                    	<%
	                    	rs = con.doSqlQuery("SELECT * FROM prescription ORDER BY pre_id");
                			
                			try {
                				while(rs.next()) {
                					%>
                					<option value="<%= rs.getInt("pre_id") %>"><%= rs.getString("pre_name") %> [<%= rs.getInt("pre_id") %>]</option>
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
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="button" name="createProductBatchSub" value="Opret" /></td>
            	<td></td>
            </tr>
        </table>
	</form>
</div>