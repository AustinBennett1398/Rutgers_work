<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>


<body>
Enter the username and password desired for the customer representative account.<br>
For security reasons, employee passwords must be between 8 and 45 characters in length.

<form method="post" action="validateCRaccount.jsp">
<table>
<tr><td>Username: </td><td><input type="text" name="username" maxlength=44></td></tr>
<tr><td>Password: </td><td><input type="password" name="password" placeholder="Must be >= 8 characters" maxlength=44></td></tr>
</table>
<input type="submit" value="Create Account" />
</form>

</body>
</html>