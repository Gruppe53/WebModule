<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	$(".actionBtn").click(function(e) {
		var showDiv = this.getAttribute("title");
		$("#"+showDiv).css("display", "block");
		
		if(showDiv == "userEdit") {
			// TODO
		}
	});
	
	$("#userCreateForm").validate({
		rules: {
			u_id: {
				required: true,
				minlength: 10
			},
			u_name: {
				required: true,
				minlength: 4,
				regex: /asdasd/
			},
			u_cprf: {
				required: true,
				minlength: 6,
				maxlength: 6,
				number: true
			},
			u_cprl: {
				required: true,
				minlength: 4,
				maxlength: 4,
				number: true
			},
			password: {
				required: true,
				regex: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/	// Must contain 1 digit, 1 small letter and 1 capital letter
			},
			passwordrepeat: {
				required: true,
				equalTo: "#password"
			},
			u_level: {
				required: true
			}
		}
	});
</script>
<h1>brugere</h1>
<div title="userCreate" class="actionBtn" style="width: 120px">opret bruger</div><div title="userEdit" class="actionBtn" style="width: 145px;">inaktive brugere</div>
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
<div id="userCreate" style="display: none;">
	<h2>opret bruger</h2>
	<form action="" id="userCreateForm" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="u_id">Bruger id</label>
                </td>
                <td>
                	<input id="u_id" name="u_id" type="text" maxlength="8" placeholder="xxx123" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_name">Navn</label>
                </td>
                <td>
          			<input id="u_name" name="u_name" type="text" maxlength="100" placeholder="Anders Andersen..." />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_cprf">CPR</label>
                </td>
                <td>
            		<input id="u_cprf" name="ucpr" type="text" maxlength="6" placeholder="ddmmyy" style="width: 53px; margin-left: 2px;" /> - 
           			<input id="u_cprl" name="ucpr" type="text" maxlength="4" placeholder="cccc" style="width: 30px;" />
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
                	<label for="u_level">Brugerniveau</label>
                </td>
                <td>
                    <select id="u_level" name="u_level">
                    	<option selected="selected" disabled="disabled">Brugerniveau</option>
                        <option value="1">Administrator</option>
                        <option value="2">Farmaceut</option>
                        <option value="3">Værkfører</option>
                        <option value="4">Operatør</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input disabled="disabled" type="submit" name="createUserSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="userEdit" style="display: none;">
	<h2>rediger bruger</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="u_id">Bruger id</label>
                </td>
                <td>
                	<input id="u_id" name="u_id" type="text" maxlength="8" value="bsd3451" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_name">Navn</label>
                </td>
                <td>
          			<input id="u_name" name="u_name" type="text" maxlength="100" value="Boris Stymanowzky Dimitriscz" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_cprf">CPR</label>
                </td>
                <td>
            		<input id="u_cprf" name="ucpr" type="text" maxlength="6" style="width: 53px; margin-left: 2px;" value="120354" /> - 
           			<input id="u_cprl" name="ucpr" type="text" maxlength="4" style="width: 30px;" value="3245" />
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
                	<label for="u_level">Brugerniveau</label>
                </td>
                <td>
                    <select id="u_level" name="u_level">
                        <option value="admin" selected="selected">Administrator</option>
                        <option value="farmaceut">Farmaceut</option>
                        <option value="værkfører">Værkfører</option>
                        <option value="operatør">Operatør</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="submit" value="Fortryd" /><input type="submit" name="editUserSub" value="Rediger" /></td>
            </tr>
        </table>
	</form>
</div>