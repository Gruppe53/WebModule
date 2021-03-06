<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 1) {
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
	});
	
	$("img[name*='deleteUserId']").click(function(e) {
		var uid = this.getAttribute("name").substring(12);
		
		$.post(
			"DeleteServlet",
			{id:uid, to:"d"},
			function(response) {
				alert(response);
				
				$('#container').fadeOut('fast', function() {
					$.get(
						"users.jsp",
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
	
	$("img[name*='upgradeUserId']").click(function(e) {
		var uid = this.getAttribute("name").substring(13);
		
		$.post(
			"DeleteServlet",
			{id:uid, to:"u"},
			function(response) {
				alert(response);
				
				$('#container').fadeOut('fast', function() {
					$.get(
						"users.jsp",
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
	
	$("img[name*='editUserId']").click(function(e) {
		var id = this.getAttribute("name").substring(10);
		
		$.get(
			"EditUserServlet",
			{u_id:id},
			function(response) {
				var userInfo = response.split("||");
				
				$("form#userEditForm input[name='u_id']").val(userInfo[0]);
				$("form#userEditForm input[name='u_name']").val(userInfo[1]);
				
				var cprf = userInfo[2].substring(0, 6);
				var cprl = userInfo[2].substring(6);
				
				$("form#userEditForm input[id='u_cprf']").val(cprf);
				$("form#userEditForm input[id='u_cprl']").val(cprl);
				$("form#userEditForm select[name='u_level']").val(userInfo[3]);
				
				$("div#userEdit").fadeIn("fast");
			},
			"html"
		);
	});
	
	$("input[name='editUserSub']").click(function(e) {
		var id = $("form#userEditForm input[name='u_id']").val();
		var name = $("form#userEditForm input[name='u_name']").val();
		var cpr = $("form#userEditForm input[id='u_cprf']").val() + $("form#userEditForm input[id='u_cprl']").val();
		var lvl = $("form#userEditForm select[name='u_level']").val();
		
		var pass = $("form#userEditForm select[name='password']").val();
		var passr = $("form#userEditForm select[name='passwordrepeat']").val();
		
		$.post(
			"EditUserServlet",
			{u_id:id, u_name:name, u_cpr:cpr, password:pass, passwordrepeat:passr, u_level:lvl},
			function(response) {
				alert(response);
				$('#container').fadeOut('fast', function() {
					$.get(
						"users.jsp",
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
	
	$("input[name='createUserSub']").click(function(e) {
		var id = $("#userCreateForm input[name='u_id']").val();
		var name = $("#userCreateForm input[name='u_name']").val();
		var cpr = $("#userCreateForm input[name='u_cprf']").val() + $("input[name='u_cprl']").val();
		var password_x = $("#userCreateForm input[name='password']").val();
		var password_y = $("#userCreateForm input[name='passwordrepeat']").val();
		var level = $("#userCreateForm select[name='u_level']").val();
		
		$.post(
			"CreateUserServlet",
			{u_id:id, u_name:name, u_cpr:cpr, password:password_x, passwordrepeat:password_y, u_level:level},
			function(response) {
				alert(response);
				
				$('#container').fadeOut('fast', function() {
					$.get(
						"users.jsp",
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
	
	$("#userCreateForm").validate({
		// Form validation rules
		rules: {		
			u_id: {
				required: true,
				minlength: 8,
				number: true,
				regex: /^([1-9]\d{7}){1}$/
			},
			u_name: {
				required: true,
				minlength: 4,
				maxlength: 100,
				regex: /^([a-zA-Z]+[^0-9]*)$/
			},
			u_cprf: {
				required: true,
				minlength: 6,
				maxlength: 6,
				number: true,
				regex: /^(0[1-9]|[1-2][0-9]|3[0-1])[.\-/]?(0[1-9]|1[0-2])[.\-/]?([0-9]{2})$/
				// READ COMMENT IN DROPBOX FOLDER: regexDateComment.txt
			},
			u_cprl: {
				required: true,
				minlength: 4,
				maxlength: 4,
				number: true
			},
			password: {
				required: true,
				minlength: 8,
				maxlength: 100,
				regex: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/
				// Must contain 1 digit, 1 small letter and 1 capital letter
			},
			passwordrepeat: {
				required: true,
				equalTo: "#password"
			},
			u_level: {
				required: true
			}
		},
		
		// Error messages upon validation
		messages: {		
			u_id: {
				required: "Indtast et bruger-ID.",
				number: "Bruger-ID kan kun indeholde tal.",
				regex: "ID kan ikke starte med 0.",
				minlength: "Bruger-ID skal være 10 karaktere langt."
			},
			u_name: {
				required: "Indtast brugerens navn.",
				minlength: "Undgå initialer og des lige, skriv deres fulde navn.",
				maxlength: "Navne på mere end 100 tegn, kan ikke gemmes i databasen.",
				regex: "Navne indeholder ikke tal."
			},
			u_cprf: {
				required: "Indtast fødselsdato for brugeren.",
				number: "Skal være i formatet ddmmåå - brug kun tal.",
				minlength: "Skal være i formatet ddmmåå - brug f.eks. 05 i stedet for 5.",
				maxlength: "Skal være i formatet ddmmåå - brug f.eks. 05 i stedet for 5.",
				regex: "Indtast en gyldig dato."
			},
			u_cprl: {
				required: "Indtast de sidste fire cifre i brugerens CPR-nummer.",
				minlength: "Der skal indtastes fire cifre.",
				maxlength: "Der skal indtastes fire cifre.",
				number: "Brug kun tal."
			},
			password: {
				required: "Indtast et password på minimum 8 bogstaver.",
				minlength: "Password skal minimum være 8 karaktere langt.",
				regex: "Mindst 1 lille og stort bogstav, samt 1 tal."
			},
			passwordrepeat: {
				required: "Indtast password igen.",
				equalTo: "Matcher ikke det forrige password."
			},
			u_level: {
				required: "Vælg et brugerniveau."
			}
			
			/*
				Need to put in some way of positioning the error messages in the following <td class="error">-element,
				of the current element being validated.
				errorPlacement has been tried, no luck. Might work if someone else tries it.
			*/
		}
	});
	
	$("#userEditForm").validate({
		rules: {		
			u_name: {
				required: true,
				minlength: 4,
				maxlength: 100,
				regex: /^([a-zA-Z]+[^0-9]*)$/
			},
			u_cprf: {
				required: true,
				minlength: 6,
				maxlength: 6,
				number: true,
				regex: /^(0[1-9]|[1-2][0-9]|3[0-1])[.\-/]?(0[1-9]|1[0-2])[.\-/]?([0-9]{2})$/
				// READ COMMENT IN DROPBOX FOLDER: regexDateComment.txt
			},
			u_cprl: {
				required: true,
				minlength: 4,
				maxlength: 4,
				number: true
			},
			password: {
				required: true,
				minlength: 8,
				maxlength: 100,
				regex: /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/
				// Must contain 1 digit, 1 small letter and 1 capital letter
			},
			passwordrepeat: {
				required: true,
				equalTo: "#password"
			},
			u_level: {
				required: true
			}
		},
		messages: {		
			u_name: {
				required: "Indtast brugerens navn.",
				minlength: "Undgå initialer og des lige, skriv deres fulde navn.",
				maxlength: "Navne på mere end 100 tegn, kan ikke gemmes i databasen.",
				regex: "Navne indeholder ikke tal."
			},
			u_cprf: {
				required: "Indtast fødselsdato for brugeren.",
				number: "Skal være i formatet ddmmåå - brug kun tal.",
				minlength: "Skal være i formatet ddmmåå - brug f.eks. 05 i stedet for 5.",
				maxlength: "Skal være i formatet ddmmåå - brug f.eks. 05 i stedet for 5.",
				regex: "Indtast en gyldig dato."
			},
			u_cprl: {
				required: "Indtast de sidste fire cifre i brugerens CPR-nummer.",
				minlength: "Der skal indtastes fire cifre.",
				maxlength: "Der skal indtastes fire cifre.",
				number: "Brug kun tal."
			},
			password: {
				required: "Indtast et password på minimum 8 bogstaver.",
				minlength: "Password skal minimum være 8 karaktere langt.",
				regex: "Mindst 1 lille og stort bogstav, samt 1 tal."
			},
			passwordrepeat: {
				required: "Indtast password igen.",
				equalTo: "Matcher ikke det forrige password."
			},
		
			u_level : {
				required : "Vælg et brugerniveau."
					}
				}
		});
</script>
<h1>brugere</h1>
<div title="userCreate" class="actionBtn" style="width: 120px">opret bruger</div><div title="inactiveUserList" class="actionBtn" style="width: 145px;">inaktive brugere</div>
<div style="clear: both;"></div>
<div id="userList">
	<h2>brugere</h2>
    <table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>cpr</strong></td>
            <td><strong>niveau</strong></td>
            <td style="width: 6%;"></td>
        </tr>
       	<%
       		DBAccess con = new DBAccess();
			ResultSet rs = con.doSqlQuery("SELECT * FROM user WHERE u_active = 1");
		
			try {
				int i = 0;
				
				while(rs.next()) {
					int userInt = rs.getInt("u_level");
					String userStr = null;
					
					if (userInt == 1)
						userStr = "Administrator";
					else if (userInt == 2)
						userStr = "Farmaceut";
					else if (userInt == 3)
						userStr = "Værkfører";
					else if (userInt == 4)
						userStr = "Operatør";
					else
						userStr = "Ukendt";
					
					if(i % 2 == 0) {
						%>
						<tr class="tableHover">
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= userStr %></td>
				            <td style="text-align: center;"><img alt="editUserId<%= rs.getInt("u_id") %>" name="editUserId<%= rs.getInt("u_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" name="deleteUserId<%= rs.getInt("u_id") %>" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></td>
				        </tr>
						<%
					}
					else {
						%>
						<tr>
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= userStr %></td>
				            <td style="text-align: center;"><img alt="editUserId<%= rs.getInt("u_id") %>" name="editUserId<%= rs.getInt("u_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" name="deleteUserId<%= rs.getInt("u_id") %>" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></td>
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
<div id="inactiveUserList" style="display: none;">
	<h2>inaktive brugere</h2>
    <table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>cpr</strong></td>
            <td><strong>niveau</strong></td>
            <td style="width: 6%;"></td>
        </tr>
       	<%
			rs = con.doSqlQuery("SELECT * FROM user WHERE u_active = 0");
		
			try {
				int i = 0;
				
				while(rs.next()) {
					int userInt = rs.getInt("u_level");
					String userStr = null;
					
					if (userInt == 1)
						userStr = "Administrator";
					else if (userInt == 2)
						userStr = "Farmaceut";
					else if (userInt == 3)
						userStr = "Værkfører";
					else if (userInt == 4)
						userStr = "Operatør";
					else
						userStr = "Ukendt";
					
					if(i % 2 == 0) {
						%>
						<tr class="tableHover">
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= userStr %></td>
				            <td style="text-align: center;"><img alt="editUserId<%= rs.getInt("u_id") %>" name="editUserId<%= rs.getInt("u_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" name="upgradeUserId<%= rs.getInt("u_id") %>" src="image/iconUpgrade.png" style="width: 12px; height: 12px;" /></td>
				        </tr>
						<%
					}
					else {
						%>
						<tr>
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= userStr %></td>
				            <td style="text-align: center;"><img alt="editUserId<%= rs.getInt("u_id") %>" name="editUserId<%= rs.getInt("u_id") %>" src="image/iconEdit.png" style="width: 12px; height: 12px;" /><img alt="delete" name="upgradeUserId<%= rs.getInt("u_id") %>" src="image/iconUpgrade.png" style="width: 12px; height: 12px;" /></td>
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
	<form id="userCreateForm" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="u_id">Bruger id</label>
                </td>
                <td>
                	<input id="u_id" name="u_id" type="text" maxlength="8" placeholder="12345678" />
				</td>
				<td class="u_id_error"></td>
            </tr>
            <tr>
            	<td>
                	<label for="u_name">Navn</label>
                </td>
                <td>
          			<input id="u_name" name="u_name" type="text" maxlength="100" placeholder="Anders Andersen..." />
				</td>
				<td></td>
            </tr>
            <tr>
            	<td>
                	<label for="u_cprf">CPR</label>
                </td>
                <td>
            		<input id="u_cprf" name="u_cprf" type="text" maxlength="6" placeholder="ddmmyy" style="width: 53px; margin-left: 2px;" /> - 
           			<input id="u_cprl" name="u_cprl" type="text" maxlength="4" placeholder="cccc" style="width: 30px;" />
				</td>
				<td class="u_cprf_error u_cprl_error"></td>
            </tr>
            <tr>
            	<td>
                	<label for="password">Password</label>
                </td>
                <td>
					<input id="password" name="password" type="password" maxlength="100" placeholder="Password" />
				</td>
				<td class="password_error"></td>
            </tr>
            <tr>
            	<td>
                	<label for="passwordrepeat">Gentag password</label>
                </td>
                <td>
					<input id="passwordrepeat" name="passwordrepeat" type="password" maxlength="100" placeholder="Gentag password" />
				</td>
				<td class="passwordrepeat_error"></td>
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
                <td class="u_level_error"></td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="button" name="createUserSub" value="Opret" /></td>
            	<td></td>
            </tr>
        </table>
	</form>
</div>
<div id="userEdit" style="display: none;">
	<h2>rediger bruger</h2>
	<form id="userEditForm" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="u_id">Bruger id</label>
                </td>
                <td>
                	<input id="u_id" name="u_id" type="text" maxlength="8" value="" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_name">Navn</label>
                </td>
                <td>
          			<input id="u_name" name="u_name" type="text" maxlength="100" value="" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="u_cprf">CPR</label>
                </td>
                <td>
            		<input id="u_cprf" name="ucpr" type="text" maxlength="6" style="width: 53px; margin-left: 2px;" value="" /> - 
           			<input id="u_cprl" name="ucpr" type="text" maxlength="4" style="width: 30px;" value="" />
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
                        <option value="1">Administrator</option>
                        <option value="2">Farmaceut</option>
                        <option value="3">Værkfører</option>
                        <option value="4">Operatør</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="submit" value="Fortryd" /><input type="button" name="editUserSub" value="Rediger" /></td>
            </tr>
        </table>
	</form>
</div>