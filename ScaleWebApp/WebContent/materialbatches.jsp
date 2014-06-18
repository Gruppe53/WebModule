<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 3) {
		out.println("document.location = ''");
	}
	%>
</script>
<h1>råvarebatches</h1>
<div title="materialbatchCreate" class="actionBtn" style="width: 160px">opret råvarebatch</div>
<div style="clear: both;"></div>
<div id="materialBatchList">
	<h2>råvarebatches</h2>
	<table>
		<tr>
			<td><strong>id</strong></td>
			<td><strong>råvare id</strong></td>
			<td><strong>mængde</strong></td>
			<td style="width: 6%;"></td>
		</tr>
		<%
			DBAccess con = new DBAccess("localhost", 3306, "gruppe55", "root", "");
			ResultSet rs = con.doSqlQuery("SELECT * FROM matbatch");
	
			try {
				int i = 0;
				
				while(rs.next()) {
					if(i % 2 == 0) {
						%>
						<tr class="tableHover">
							<td><%= rs.getInt("mb_id") %> </td>
							<td><%= rs.getInt("m_id") %> </td>
							<td><%= rs.getInt("amount") + " g" %> </td>
							<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
						</tr>
						<%
					}
					else {
						%>
						<tr>
							<td><%= rs.getInt("mb_id") %> </td>
							<td><%= rs.getInt("m_id") %> </td>
							<td><%= rs.getInt("amount") + " g"%> </td>
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
<div id="createMaterialBatch">
	<h2>opret råvarebatch</h2>
	<form id="createMaterialBatchForm">
		<table>
			<tr>
				<td><label for="mb_id">y0</label></td>
				<td><input name="mb_id" value="" placeholder="12345678" /></td>
			</tr>
		</table>
	</form>
</div>