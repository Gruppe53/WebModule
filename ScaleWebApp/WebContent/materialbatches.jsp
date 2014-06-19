<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 3) {
		out.println("document.location = ''");
	}
	%>
	
	$(".actionBtn").click(function(e) {
		showDiv = this.getAttribute("title");
		var display = $("#" + showDiv).css("display");
		
		if(display == "none")
			$("#" + showDiv).fadeIn("fast");
		else if(display == "block")
			$("#" + showDiv).fadeOut("fast");
		
		if(showDiv == "materialBatchEdit") {
			// TODO
		}
	});
	
	$("#materialBatchCreateForm").validate({
		rules: {
			mb_id: {
				required: true,
				minlength: 8,
				number: true
			},
			mb_amount: {
				required: true,
				number:true
			},
			m_id: {
				required: true
			}
		},
		messages: {
			mb_id: {
				required: "Indtast et råvarebatch-ID.",
				minlength: "Råvarebatch-ID skal være på 8 tal.",
				number: "Råvarebatch-ID skal være tal."
			},
			mb_amount: {
				required: "Indtast mængden.",
				number: "Mængden skal være tal."
			},
			m_id: {
				required: "Vælg en recept."
			}
		}
	});
	
	$("input[name='creatematerialBatchSub']").click(function(e) {
		var id = $("input[name='mb_id']").val();
		var amount = $("input[name='mb_amount']").val();
		var mid = $("select[name='m_id']").val();
		
		$.post(
			"CreateMaterialbatchServlet",
			{mb_id:id, mb_amount:amount, m_id:mid},
			function(response) {
				alert(response);
				
				$("#container").fadeOut("fast", function() {
					$.get(
						"materials.jsp", //TODO check here if right '.jsp' ?
						function(data) {
							$("#container").html(data).fadeIn("fast");
						},
						"html"
					);
				});
			},
			"html"
		);
	});
</script>
<h1>råvarebatches</h1>
<div title="materialBatchCreate" class="actionBtn" style="width: 160px">opret råvarebatch</div>
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
			DBAccess con = new DBAccess();
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
<div id="materialBatchCreate" style="display: none;">
	<h2>opret råvarebatch</h2>
	<form id="materialBatchCreateForm" method="post">
		<table>
			<tr>
				<td><label for="mb_id">Råvarebatch ID</label></td>
				<td><input id="mb_id" name="mb_id" placeholder="12345678" maxlength="8" type="text" /></td>
			</tr>
			<tr>
				<td><label for="mb_amount">Mængde</label>
				<td><input id="mb_amount" name="mb_amount" placeholder="10000000" type="text" maxlength="20"></td>
			</tr>
			<tr>
				<td><label for="m_id">Råvare</label></td>
            	<td>
            		<select id="m_id" name="m_id">
            			<option selected="selected" disabled="disabled">Komponent...</option>
            			<%
							rs = con.doSqlQuery("SELECT m_id, m_name FROM materials");
							
							try {
								while(rs.next()) {
									%>
									<option value="<%= rs.getInt("m_id") %>"><%= rs.getString("m_name") %> [<%= rs.getInt("m_id") %>]</option>
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
				<td style="text-align: right;" colspan="2"><input type="reset" value="Nulstil" /><input name="creatematerialBatchSub" type="button" value="Opret" /></td>
			</tr>
		</table>
	</form>
</div>