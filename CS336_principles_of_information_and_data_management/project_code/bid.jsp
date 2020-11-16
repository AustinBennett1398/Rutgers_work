<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make a Bid</title>
</head>
<body>
    
    <form method="post" action="completeBid.jsp">
    Auction Number: <input name="test" type="number"> <br>
    Bid Amount: <input name="bid_amt" type="number" step="0.01"> <br>
    Auto bid up to: <input name="autobid" type="number" step="0.01"> <br>
    <input type="submit" value ="Submit Bid"/>
    </form>
    <%
    out.println();
    out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
    %>
    
    
</body>
</html>