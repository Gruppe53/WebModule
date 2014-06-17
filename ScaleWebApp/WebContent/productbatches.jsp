<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<h1>produktbatches</h1>
<div title="productbatchCreate" class="actionBtn" style="width: 160px">opret produktbatch</div>
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
			DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
			ResultSet rs = con.doSqlQuery("SELECT * FROM productbatch");
			
			try {
				int i = 0;
				
				while(rs.next()) {
					if (i % 2 == 0) {
						%>
						<tr class="tableHover">
							<td><%= rs.getInt("pb_id") %>	</td>
							<td><%= rs.getInt("status") %>	</td>
							<td><%= rs.getInt("pre_id") %>	</td>
							<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
						</tr>
						<%
					}
					else {
						%>
						<tr>
							<td><%= rs.getInt("pb_id") %>	</td>
							<td><%= rs.getInt("status") %>	</td>
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