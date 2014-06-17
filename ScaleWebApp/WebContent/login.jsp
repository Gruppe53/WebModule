<%@	page language="java" errorPage="" pageEncoding="UTF-8" %>
<script>
	$("#loginForm").validate({
		rules: {
			username: {
				required: true,
				minlength: 8
			},
			password: {
				required: true,
				minlength: 8
			}
		},
		messages: {
			username: {
				required: "Indtast et brugernavn.",
				minlength: "Brugernavn er minimum 8 karaktere langt."
			},
			password: {
				required: "Indtast et password.",
				minlength: "Password skal minimum være 8 karaktere langt."
			}
		}
	});
</script>
<h2>login</h2>
<p>Vær venlig at logge ind.</p>
<form action="LoginServlet" id="loginForm" method="post">
    <table>
        <tr>
            <td align="left">Brugernavn</td>
            <td align="left"><input class="loginBoxInput" name="username" type="text"></td>
        </tr>
        <tr>
            <td align="left">Password</td>
            <td align="left"><input class="loginBoxInput" name="password" type="password"></td>
        </tr>
        <tr>
            <td align="right" colspan="2"><input name="loginSubmit" type="submit" value="Login"></td>
        </tr>
    </table>
</form>