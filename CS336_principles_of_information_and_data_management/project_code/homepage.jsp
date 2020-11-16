<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BuyMe Home</title>
</head>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
</div>

<body>
<%=session.getAttribute("user")%>, welcome to BuyMe!
<br><br><br>
<%
Integer access = (Integer) session.getAttribute("access_level");

//LocalDateTime x = LocalDateTime.parse("2020-05-24T04:20:00");
//out.println(x);
//User
if(access >= 1)
{
	out.println("End User Commands <br> <br>");
	out.println("<a href='forums.jsp'><button tye='button'>View Forums</button></a><br><br>");
	
	out.println("<a href='searchIndex.jsp'><button type = 'button'>Search for an auction</button></a><br><br>");
	
	out.println("<a href='createAuction.jsp'><button type = 'button'>Create Auction</button></a><br><br>");
	out.println("<a href='bid.jsp'><button type = 'button'>Place a bid</button></a><br><br>");
	
	out.println("<a href='setalert.jsp'><button type='button'>Set alert</button></a><br><br>");
	out.println("<a href='clearalert.jsp'><button type='button'>Clear all alerts</button></a><br><br>");
	out.println("<a href='clearspecificalert.jsp'><button type='button'>Delete a specific alert</button></a><br><br>");
	
	out.println("<a href='beforeCheckWinner.jsp'><button type = 'button'>Check winner of an auction</button></a><br><br>");
}
//Customer Rep
if(access >= 2)
{
	out.println("Customer Rep Commands <br> <br>");
	out.println("<a href='deleteAuction.jsp'><button type='button'>Delete an auction</button></a><br><br>");
	out.println("<a href='deleteBid.jsp'><button type='button'>Delete a bid</button></a><br><br>");
	out.println("<a href='editAccount.jsp'><button type='button'>Edit accounts, auctions, bids</button></a><br><br>");

	out.println("<a href='forumReply.jsp'><button type='button'>Answer Forum Question</button></a><br><br>");
}
//Administrator
if(access >= 3)
{
	out.println("Administrator Commands <br> <br>");
	out.println("<a href='createCR.jsp'><button type='button'>Create Customer Rep account</button></a><br><br>");
	out.println("<a href='salesReports.jsp'><button type='button'>View Sales Reports</button></a><br><br>");
}


out.println("<a href='logout.jsp'><button type='button'>Log Out</button></a><br><br>");


%>


</body>
</html>
