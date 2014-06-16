<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<h1>rÃ¥varebatches</h1>
<% //------------------------------------------------------- Bækhøj input start -------------------------------- %>
<div title="materialbatchCreate" class="actionBtn" style="width: 120px">opret materialbatch</div>
<div style="clear: both;"></div>
<div id="materialbatchList">
	<h2>råvarebatches</h2>
	<table>
		<tr>
			<td><strong>id</strong></td>
			<td><strong>råvare id</strong></td>
			<td><strong>mængde</strong></td>
			<td style="width: 6%;"></td>
		</tr>
		<%
			DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
			ResultSet rs = con.doSqlQuery("SELECT * FROM user");
	
		try {
			int i = 0;
			
			while(rs.next()) {
				if(i % 2 == 0) {
					%>
					<tr class="tableHover">
						<td><%= rs.getInt("mb_id") %> </td>
						<td><%= rs.getInt("m_id") %> </td>
						<td><%= rs.getInt("amount") %> </td>
						<td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
					</tr>
					<%
				}
				else {
					%>
					<tr>
						<td><%= rs.getInt("mb_id") %> </td>
						<td><%= rs.getInt("m_id") %> </td>
						<td><%= rs.getInt("amount") %> </td>
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
<% //------------------------------------------------------- Bækhøj input slut -------------------------------- %>
<div id="materialBatchList">
	<h2>rÃ¥varebatches</h2>
    <table style="width: 40%">
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>mÃ¦ngde</strong></td>
            <td><strong>enhed</strong></td>
            <td style="width: 14%"></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>235432</td>
            <td style="text-align: right;">234,54</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>762544</td>
            <td style="text-align: right;">633,22</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>765243</td>
            <td style="text-align: right;">56,1</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>521646</td>
            <td style="text-align: right;">65,61</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>123635</td>
            <td style="text-align: right;">4562,46</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>851457</td>
            <td style="text-align: right;">2356,13</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>235163</td>
            <td style="text-align: right;">174,88</td>
			<td>g</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
    </table>
</div>
