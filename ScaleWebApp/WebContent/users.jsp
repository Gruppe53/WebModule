<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<h1>brugere</h1>
<div class="actionBtn" style="width: 120px">opret bruger</div><div class="actionBtn" style="width: 145px;">inaktive brugere</div>
<div style="clear: both;"></div>
<div id="userList">
	<h2>brugere</h2>
    <table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>cpr</strong></td>
            <td><strong>niveau</strong></td>
            <td></td>
        </tr>
       	<%
       		DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
			ResultSet rs = con.doSqlQuery("SELECT * FROM user");
		
			try {
				int i = 0;
				
				while(rs.next()) {
					if(i % 2 == 0) {
						%>
						<tr bgcolor="#dfecff">
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= rs.getInt("u_level") %></td>
				            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
				        </tr>
						<%
					}
					else {
						%>
						<tr>
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= rs.getInt("u_level") %></td>
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
<div id="userCreate">
	<h2>opret bruger</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="uid">Bruger id</label>
                </td>
                <td>
                	<input id="uid" name="uid" type="text" maxlength="8" placeholder="xxx123" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="uname">Navn</label>
                </td>
                <td>
          			<input id="uname" name="uname" type="text" maxlength="100" placeholder="Anders Andersen..." />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="ucprf">CPR</label>
                </td>
                <td>
            		<input id="ucprf" name="ucpr" type="text" maxlength="6" placeholder="ddmmÃ¥Ã¥" style="width: 53px; margin-left: 2px;" /> - 
           			<input id="ucprl" name="ucpr" type="text" maxlength="4" placeholder="cccc" style="width: 30px;" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="password">Password</label>
                </td>
                <td>
					<input id="password" name="password" type="password" maxlength="100" placeholder="Password" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="passwordrepeat">Gentag password</label>
                </td>
                <td>
					<input id="passwordrepeat" name="passwordrepeat" type="password" maxlength="100" placeholder="Gentag password" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="ulevel">Brugerniveau</label>
                </td>
                <td>
                    <select id="ulevel" name="ulevel">
                    	<option selected="selected" disabled="disabled">Brugerniveau</option>
                        <option value="admin">Administrator</option>
                        <option value="farmaceut">Farmaceut</option>
                        <option value="værkører">Værkfører</option>
                        <option value="operatør">Operatør</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createUserSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="userEdit">
	<h2>rediger bruger</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="uid">Bruger id</label>
                </td>
                <td>
                	<input id="uid" name="uid" type="text" maxlength="8" value="bsd3451" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="uname">Navn</label>
                </td>
                <td>
          			<input id="uname" name="uname" type="text" maxlength="100" value="Boris Stymanowzky Dimitriscz" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="ucprf">CPR</label>
                </td>
                <td>
            		<input id="ucprf" name="ucpr" type="text" maxlength="6" style="width: 53px; margin-left: 2px;" value="120354" /> - 
           			<input id="ucprl" name="ucpr" type="text" maxlength="4" style="width: 30px;" value="3245" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="password">Nyt password</label>
                </td>
                <td>
					<input id="password" name="password" type="password" maxlength="100" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="passwordrepeat">Gentag nyt password</label>
                </td>
                <td>
					<input id="passwordrepeat" name="passwordrepeat" type="password" maxlength="100" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="ulevel">Brugerniveau</label>
                </td>
                <td>
                    <select id="ulevel" name="ulevel">
                        <option value="admin" selected="selected">Administrator</option>
                        <option value="farmaceut">Farmaceut</option>
                        <option value="værkfører">Værkfører</option>
                        <option value="operatør">Operatør</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="submit" value="Fortryd" /><input type="submit" value="editUserSub" value="Rediger" /></td>
            </tr>
        </table>
	</form>
</div>