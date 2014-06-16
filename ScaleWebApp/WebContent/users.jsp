<%@	page language="java" import="java.sql.*, java.util.*, java.text.*, databaseAccess.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	$(".actionBtn").click(function(e) {
		var showDiv = this.getAttribute("title");
		var display = $("#" + showDiv).css("display");
		
		if(display == "none")
			$("#" + showDiv).css("display", "block");
		else if(display == "block")
			$("#" + showDiv).css("display", "none");
		
		if(showDiv == "userEdit") {
			// TODO
		}
	});
	
	$("#userCreateForm").validate({
		// Form validation rules
		rules: {		
			u_id: {
				required: true,
				minlength: 10,
				number: true,
				regex: /^([1-9]\d{9}){1}$/
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
				/*	Date which accepts ddmmyy, dd-mm/yy, dd.mm-yy (and any combination of ".", "-" and "/")
					Wrongly accepts eg. 30-02-yy (hint: there's never more than 29 days in february)
					A work-around would be to include matches (negated) for all months, which has 28 or only 30 days in it
					How to include leap years.... meh.... no idea.
					
					If anyone feels for it, the rules are as following:
					
					if (year is not divisible by 4)
						common year
					else if (year is not divisible by 100)
						leap year
					else if (year is not divisible by 400)
						common year
					else
						leap year
				
					Oh and by the way: the greatest problem lies in the fact, that the year is entered as yy and not yyyy.
					Have fun finding an acceptable solution.
				
					If you don't feel like doing it with regex, you could just create your own validating method.
					This is done by doing:
				
					$.validation.addMethod("<name>",
						function(value, element, <parameters>) {
							code here;
							return <error> || <success>;
						},
						"<error message>"
					);
					- <name> is the name which we use to call the validating method (eg. required, minlength, number etc.)
					- <paramters> are types which will be followed by the call of the method (whatever you put after you call
					  the method - eg. "required: true", here it is "true" which is being followed as a boolean.)
					  I don't know if it takes more than 1 parameter. Eg. if we created the method foo and then called the
					  method with "foo: {true, 'someStringText'}" that it then would accept function-parameters as 
					  function(value, element, <nameOfBooleanType>, <nameOfStringType>)
					- and then allow us to use <nameOfBooleanType> and <nameOfStringType> as vars inside the function.
					- <error> is the element which should be returned if something went wrong
					- <success> take a guess...
					- <error message> is the message which automatically should be appended NEXT to the validated object
				
					There might be some built-in method - I don't know. If they're available, you will probably find them
					in the "additional-methods.js"-file. Maybe they're only available through the localization files.
					You'll have to download the localization files yourself (they're a part of the validation plugin - google it).*/
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
				regex: "Password skal indeholde mindst 1 lille bogstav, 1 stort bogstav og 1 tal."
			},
			passwordrepeat: {
				required: "Indtast password igen.",
				equalTo: "Matcher ikke det forrige password."
			},
			u_level: {
				required: "Vælg et brugerniveau."
			}
		}
	});
</script>
<h1>brugere</h1>
<div title="userCreate" class="actionBtn" style="width: 120px">opret bruger</div><div class="actionBtn" style="width: 145px;">inaktive brugere</div>
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
						<tr class="tableHover">
				        	<td><%= rs.getInt("u_id") %></td>
				            <td><%= rs.getString("u_name") %></td>
				            <td><%= rs.getString("u_cpr").substring(0, 6) %> - <%= rs.getString("u_cpr").substring(6, 10) %></td>
				            <td><%= rs.getInt("u_level") %></td>
				            <td style="text-align: center;"><a href=""><img alt="edit" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="delete" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
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
<div id="userCreate" style="display: none;">
	<h2>opret bruger</h2>
	<form action="" id="userCreateForm" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="u_id">Bruger id</label>
                </td>
                <td>
                	<input id="u_id" name="u_id" type="text" maxlength="10" placeholder="xxx123" />
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
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createUserSub" value="Opret" /></td>
            	<td></td>
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