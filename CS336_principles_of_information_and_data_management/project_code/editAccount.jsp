<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<body>

Note: You can not change an account from user to customer rep due to the increased security on the passwords of employees that is required.
<form method="post" action="changePassword.jsp">
<table>
<tr><td>User to change: </td><td><input type="text" name="usr"></td></tr>
<tr><td>New password: </td><td><input type="password" name="pwd"></td></tr>
</table>
<input type="submit" value="Change password" />
</form>
<br><br>

<form method="post" action="changeAuction.jsp">
Auction number: <input type="text" name="auction_number" maxlength=9>
<input type="submit" value="Edit Auction">
</form>

<br><br>
(Will update the most recent bid only)
<form method="post" action="updateBid.jsp">
Account number of auction: <input type="text" name="auction_number" maxlength=9><br>
Username of bidder: <input type="text" name="username" maxlength=44><br>
Change bid to:     <input type="number" name="bid_amt"><br>
<input type="submit" value="Update Bid">
</form>


</body>
</html>
