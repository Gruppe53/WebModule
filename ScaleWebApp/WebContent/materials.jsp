<%@	page language="java" import="java.sql.*, java.util.*, java.text.*,database.*" errorPage="" pageEncoding="UTF-8" %>
<script>
	<%
	if((Integer) session.getAttribute("u_level") > 2) {
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
		
		if(showDiv == "materialEdit") {
			// TODO
		}
	});
	
	$("#materialCreateForm").validate({
		rules: {
			m_id: {
				required: true,
				minlength: 8,
				number: true
			},
			m_name: {
				required: true
			},
			s_id: {
				required: true,
				number: true
			}
		},
		messages: {
			m_id: {
				required: "Indtast et råvarenummer.",
				minlength: "Råvarenummeret skal være 8 karaktere langt.",
				number: "Råvarenummer må kun indeholde tal."
			},
			m_name: {
				required: "Indtast et råvarenavn."
			},
			s_id: {
				required: "Vælg en leverandør.",
				number: ""
			}
		}
	});
	
	$("input[name='createMaterialSub']").click(function(e) {
		var id = $("input[name='m_id']").val();
		var name = $("input[name='m_name']").val();
		var sup = $("select[name='s_name']").val();
		
		$.post(
			"CreateMaterialServlet",
			{m_id:id, m_name:name, s_name:sup},
			function(response) {
				$('#container').fadeOut('fast', function() {
					$.get(
						"materials.jsp",
						function(data) {
							$("#container").html(data).fadeIn('fast');
						},
						"html"
					);
				});
				
				if(response.substring(1,1) == "S") {
					$("input[name='m_id']").val("");
					$("input[name='m_name']").val("");
					$("select[name='s_name']").val("");
					
					var display = $("#" + showDiv).css("display");
					
					if(display == "none")
						$("#" + showDiv).fadeIn("fast");
					else if(display == "block")
						$("#" + showDiv).fadeOut("fast");
					
					$("span#latestMsg").html(response).fadeIn("fast");
				}
				else {
					$("span#latestMsg").html(response).fadeIn("fast");
				}
			},
			"html"
		);
	});
</script>
<h1>råvarer</h1>
<div title="materialCreate" class="actionBtn" style="width: 120px">opret råvare</div>
<div style="clear: both;"></div>
<div id="materialList">
	<h2>råvarer</h2>
	<table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>leverandør</strong></td>
            <td style="width: 6%"></td>
        </tr>
        <%
	        DBAccess con = new DBAccess("72.13.93.206", 3307, "gruppe55", "gruppe55", "55gruppe");
			ResultSet rs = con.doSqlQuery("SELECT * FROM materials");
		
			try {
				int i = 0;
				
				while(rs.next()) {
					if(i % 2 == 0) {
						%>
						<tr bgcolor="#dfecff">
				        	<td><%= rs.getInt("m_id") %></td>
				            <td><%= rs.getString("m_name") %></td>
				            <td><%= rs.getString("supplier") %></td>
				            <td style="text-align: center;"><a href=""><img alt="reddel" src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel" src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
				        </tr>
						<%
					}
					else {
						%>
						<tr>
				        	<td><%= rs.getInt("m_id") %></td>
				            <td><%= rs.getString("m_name") %></td>
				            <td><%= rs.getString("supplier") %></td>
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
<div id="materialCreate" style="display: none;">
	<h2>opret råvare</h2>
	<form id="materialCreateForm" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="m_id">Råvare id</label>
                </td>
                <td>
                	<input id="m_id" name="m_id" type="text" maxlength="8" placeholder="12345678" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="m_name">Navn</label>
                </td>
                <td>
          			<input id="m_name" name="m_name" type="text" maxlength="100" placeholder="Råvarenavn..." />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="s_name">Leverandør</label>
                </td>
                <td>
                    <select name="s_name">
                        <option selected="selected" disabled="disabled">Leverandør...</option>
                        <%
						rs = con.doSqlQuery("SELECT * FROM suppliers");
						
						try {
							while(rs.next()) {
								%>
								<option value="<%= rs.getString("s_name") %>"><%= rs.getString("s_name") %> [<%= rs.getInt("s_id") %>]</option>
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
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="button" name="createMaterialSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="materialEdit" style="display: none;">
	<h2>rediger råvare</h2>
	<form action="" method="post">
        <table>
        	<tr>
            	<td>
                	<label for="m_id">Råvare id</label>
                </td>
                <td>
                	<input id="m_id" name="m_id" type="text" maxlength="8" value="5434sa" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="m_name">Navn</label>
                </td>
                <td>
          			<input id="m_name" name="m_name" type="text" maxlength="100" value="Salt" />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="supplier">Leverandør</label>
                </td>
                <td>
                    <select name="supplier">
                        <option disabled="disabled">Leverandør...</option>
                        <option value="Alternova">Alternova</option>
                        <option value="Bents Biokemi">Bents Biokemi</option>
                        <option value="Takeda Pharma">Takeda Pharma</option>
                        <option value="GlaxoSmithKline Consumer Healthcare">GlaxoSmithKline Consumer Healthcare)</option>
                        <option selected="selected" value="GC Rieber Salt A/S">GC Rieber Salt A/S</option>
                    </select>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createMaterialSub" value="Opdater" /></td>
            </tr>
        </table>
	</form>
</div>
<span id="latestMsg"></span>