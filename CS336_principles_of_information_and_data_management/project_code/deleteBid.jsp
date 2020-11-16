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


<form method="post" action="checkDeleteBid.jsp">
Enter the account number for which you would like to delete the bids by the specified user.<br>
WARNING: This will delete all bids by the user on the specified auction!!<br>
<table>
<tr><td>Auction Number: </td><td><input type="number" name="auction_number" maxlength=9 min=0></td></tr>
<tr><td>Username: </td><td><input type="text" name="username" maxlength=44></td></tr>
</table>
<input type="submit" value="Delete" />
</form>

</html>