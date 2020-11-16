<!DOCTYPE html>
<html>
   <head>
      <title>Login Form</title>
   </head>
   <body>
   Log in:
     <form action="checkLoginDetails.jsp" method="POST">
       <table>
		<tr>    
		<td>Username: </td><td><input type="text" name="username"></td>
		</tr>
		<tr>    
		<td>Password: </td><td><input type="password" name="password"></td>
		</tr>
		</table>
		
		<input type="submit" value="Log in"/>
	 </form>
	 <a href="createAccount.jsp">Need to create an account?</a>
   </body>
</html>