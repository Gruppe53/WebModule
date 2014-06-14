<script>
	$("form").on("change", "select[name*='component']", function(e) {
		if($(this).closest("tr").prevAll().length == $(this).closest("tr").siblings().length) {
			var nextComponentNumber = parseInt($(this).attr("name").match(/[0-9]+/), 10) + 1;
			
			var newSelect = "<tr>"
								+ "<td>"
									+ "<select name=\"component" + nextComponentNumber + "\">"
										+ "<option selected=\"selected\" disabled=\"disabled\">Komponent...</option>"
										+ "<option value=\"5434sa\">Salt (5434sa)</option>"
										+ "<option value=\"2154pa\">Paracetamol (2154pa)</option>"
										+ "<option value=\"9885ac\">Acetylsalicylsyre (9885ac)</option>"
									+ "</select>"
								+ "</td>"
								+ "<td>"
									+ " <span class=\"delComponent\" style=\"cursor: pointer;\">x</span>"
								+ "</td>"
							+ "</tr>";
							
			$(this).closest("tr").after(newSelect);
		}
	});
	
	$("form").on("click", "span[class*='delComponent']", function(e) {
		$(this).closest("tr").remove();
	});
	
</script>
<h1>recepter</h1>
<div class="actionBtn" style="width: 120px">opret recept</div>
<div style="clear: both;"></div>
<div id="prescriptionList">
	<h2>recepter</h2>
	<table>
    	<tr>
        	<td><strong>id</strong></td>
            <td><strong>navn</strong></td>
            <td><strong>komponenter</strong></td>
            <td style="width: 6%"></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54831969</td>
            <td>Salt</td>
            <td>Natrium, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65423487</td>
            <td>Nullam</td>
            <td>Codein, Omeprazol, Paracetamol</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>25351243</td>
            <td>Maecenas sit amet</td>
            <td>Salt, Natrium, Codein, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>76542343</td>
            <td>Sed lacinia interdum</td>
            <td>Acetylsalicylsyre, Omeprazol, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54326543</td>
            <td>Aenean nibh enim</td>
            <td>Omeprazol, Chlorid, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>34642841</td>
            <td>Curabitur ut gravida</td>
            <td>Omeprazol, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54396254</td>
            <td>Aenean lacus dui</td>
            <td>Paracetamol, Acetylsalicylsyre, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12381352</td>
            <td>Aliquam varius odio</td>
            <td>Acetylsalicylsyre, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54831969</td>
            <td>Salt</td>
            <td>Natrium, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65423487</td>
            <td>Nullam</td>
            <td>Codein, Omeprazol, Paracetamol</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>25351243</td>
            <td>Maecenas sit amet</td>
            <td>Salt, Natrium, Codein, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>76542343</td>
            <td>Sed lacinia interdum</td>
            <td>Acetylsalicylsyre, Omeprazol, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54326543</td>
            <td>Aenean nibh enim</td>
            <td>Omeprazol, Chlorid, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>34642841</td>
            <td>Curabitur ut gravida</td>
            <td>Omeprazol, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54396254</td>
            <td>Aenean lacus dui</td>
            <td>Paracetamol, Acetylsalicylsyre, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12381352</td>
            <td>Aliquam varius odio</td>
            <td>Acetylsalicylsyre, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54831969</td>
            <td>Salt</td>
            <td>Natrium, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65423487</td>
            <td>Nullam</td>
            <td>Codein, Omeprazol, Paracetamol</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>25351243</td>
            <td>Maecenas sit amet</td>
            <td>Salt, Natrium, Codein, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>76542343</td>
            <td>Sed lacinia interdum</td>
            <td>Acetylsalicylsyre, Omeprazol, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54326543</td>
            <td>Aenean nibh enim</td>
            <td>Omeprazol, Chlorid, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>34642841</td>
            <td>Curabitur ut gravida</td>
            <td>Omeprazol, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54396254</td>
            <td>Aenean lacus dui</td>
            <td>Paracetamol, Acetylsalicylsyre, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12381352</td>
            <td>Aliquam varius odio</td>
            <td>Acetylsalicylsyre, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54831969</td>
            <td>Salt</td>
            <td>Natrium, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>65423487</td>
            <td>Nullam</td>
            <td>Codein, Omeprazol, Paracetamol</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>25351243</td>
            <td>Maecenas sit amet</td>
            <td>Salt, Natrium, Codein, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>76542343</td>
            <td>Sed lacinia interdum</td>
            <td>Acetylsalicylsyre, Omeprazol, Chlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54326543</td>
            <td>Aenean nibh enim</td>
            <td>Omeprazol, Chlorid, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>34642841</td>
            <td>Curabitur ut gravida</td>
            <td>Omeprazol, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr bgcolor="#dfecff">
        	<td>54396254</td>
            <td>Aenean lacus dui</td>
            <td>Paracetamol, Acetylsalicylsyre, Trospiumchlorid</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
        <tr>
        	<td>12381352</td>
            <td>Aliquam varius odio</td>
            <td>Acetylsalicylsyre, Codein</td>
            <td style="text-align: center;"><a href=""><img alt="reddel"  src="image/iconEdit.png" style="width: 12px; height: 12px;" /></a> <a href=""><img alt="reddel"  src="image/iconDelete.png" style="width: 12px; height: 12px;" /></a></td>
        </tr>
    </table>
</div>
<div id="prescriptionCreate">
	<h2>opret recept</h2>
	<form action="" method="post" id="preCreate" name="prescriptionCreate">
        <table>
        	<tr>
            	<td>
                	<label for="mid">Recept id</label>
                </td>
                <td>
                	<input id="mid" name="mid" type="text" maxlength="8" placeholder="12345678" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="rname">Navn</label>
                </td>
                <td>
          			<input id="rname" name="rname" type="text" maxlength="100" placeholder="Receptnavn..." />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="component">Komponenter</label>
                </td>
                <td style="padding: 0px 0px 0px 0px;">
                	<table id="componentsTable" style="border-spacing: 0px;">
                    	<tr>
                            <td>
                                <select name="component1">
                                    <option selected="selected" disabled="disabled">Komponent...</option>
                                    <option value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="createPrescriptionSub" value="Opret" /></td>
            </tr>
        </table>
	</form>
</div>
<div id="prescriptionEdit">
	<h2>rediger recept</h2>
	<form action="" method="post" id="preCreate" name="prescriptionCreate">
        <table>
        	<tr>
            	<td>
                	<label for="mid">Recept id</label>
                </td>
                <td>
                	<input id="mid" name="mid" type="text" maxlength="8" value="54831969" disabled="disabled" />
				</td>
            </tr>
            <tr>
            	<td>
                	<label for="rname">Navn</label>
                </td>
                <td>
          			<input id="rname" name="rname" type="text" maxlength="100" value="Salt" />
				</td>
            </tr>
            <tr>
            	<td style="vertical-align: top; text-align: left;">
                	<label for="component">Komponenter</label>
                </td>
                <td style="padding: 0px 0px 0px 0px;">
                	<table id="componentsTable" style="border-spacing: 0px;">
                    	<tr>
                            <td>
                                <select name="component1">
                                    <option disabled="disabled">Komponent...</option>
                                    <option selected="selected" value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                </select>
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                <select name="component2">
                                    <option disabled="disabled">Komponent...</option>
                                    <option value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                    <option selected="selected" value="543534">Chlorid</option>
                                </select>
                            </td>
                            <td><span class="delComponent" style="cursor: pointer"> x</span></td>
                        </tr>
                        <tr>
                            <td>
                                <select name="component3">
                                    <option selected="selected" disabled="disabled">Komponent...</option>
                                    <option value="5434sa">Salt (5434sa)</option>
                                    <option value="2154pa">Paracetamol (2154pa)</option>
                                    <option value="9885ac">Acetylsalicylsyre (9885ac)</option>
                                </select>
                            </td>
                            <td><span class="delComponent" style="cursor: pointer"> x</span></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
            	<td align="right" colspan="2"><input type="reset" value="Nulstil" /><input type="submit" name="editPrescriptionSub" value="Opdater" /></td>
            </tr>
        </table>
	</form>
</div>