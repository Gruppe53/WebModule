<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<h1>produktbatches</h1>
<% //------------------------------------------------------- Bækhøj input start -------------------------------- %>
<div title="productbatchCreate" class="actionBtn" style="width: 120px">opret productbatch</div>
<div style ="clear: both;"></div>
<div id="productbatchList">
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
			ResultSet rs = con.doSqlQuery("SELECT * FROM user");
			
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
						<tr class="tableHover">
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
<% //------------------------------------------------------- Bækhøj input slut -------------------------------- %>
<div id="productBatchList">
	<h2>produktbatches</h2>
    <table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>receptnummer</strong></td>
            <td><strong>dato</strong></td>
            <td><strong>status</strong></td>
            <td style="width: 6%"></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>75443465</td>
            <td>25351243</td>
			<td>21-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65267623</td>
            <td>54396254</td>
			<td>20-01-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>16533256</td>
            <td>65423487</td>
			<td>11-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>17427634</td>
            <td>12381352</td>
			<td>05-12-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>93163516</td>
            <td>34642841</td>
			<td>09-03-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12643582</td>
            <td>54396254</td>
			<td>27-02-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>17548524</td>
            <td>76542343</td>
			<td>22-03-2014</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>71645427</td>
            <td>65423487</td>
			<td>02-10-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>75443465</td>
            <td>25351243</td>
			<td>21-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65267623</td>
            <td>54396254</td>
			<td>20-01-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>16533256</td>
            <td>65423487</td>
			<td>11-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>17427634</td>
            <td>12381352</td>
			<td>05-12-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>93163516</td>
            <td>34642841</td>
			<td>09-03-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12643582</td>
            <td>54396254</td>
			<td>27-02-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>17548524</td>
            <td>76542343</td>
			<td>22-03-2014</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>71645427</td>
            <td>65423487</td>
			<td>02-10-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>75443465</td>
            <td>25351243</td>
			<td>21-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65267623</td>
            <td>54396254</td>
			<td>20-01-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>16533256</td>
            <td>65423487</td>
			<td>11-01-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>17427634</td>
            <td>12381352</td>
			<td>05-12-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>93163516</td>
            <td>34642841</td>
			<td>09-03-2014</td>
            <td>oprettet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12643582</td>
            <td>54396254</td>
			<td>27-02-2014</td>
            <td>under produktion</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>17548524</td>
            <td>76542343</td>
			<td>22-03-2014</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>71645427</td>
            <td>65423487</td>
			<td>02-10-2013</td>
            <td>afsluttet</td>
            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
    </table>
</div>