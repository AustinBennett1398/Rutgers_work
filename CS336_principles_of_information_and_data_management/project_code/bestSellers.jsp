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
<head>
<style>
table
{
  width:100%;
  border: 1px solid black;
  border-collapse: collapse;
}
th, td
{
  border: 1px solid black;
  border-collapse: collapse;
  text-align:center;
}
</style>
</head>

<% 
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
ResultSet rs;

String sql = "SELECT SUM(maxBid) as totalEarnings, seller FROM (SELECT max(bid_amt) as maxBid, seller FROM bid NATURAL JOIN auction WHERE bid.auction_num = auction.auction_num AND current_timestamp() > end_date GROUP BY seller) as t1 GROUP BY seller;";
rs = st.executeQuery(sql);

Double total_earnings = 0.0;

out.println("<table><tr><th><h3> Seller </h3></th><th><h3> Total Earnings </h3></th>");
while(rs.next())
{
	out.println("<tr><td>" + rs.getString("seller") + "</td><td>" + rs.getDouble("totalEarnings"));
}

con.close();
st.close();
rs.close();
%>
