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

<%
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;

String sql = "SELECT * FROM category where cat_name =" + "'" + request.getParameter("itemType") + "'";
rs = st.executeQuery(sql);

String itemType = request.getParameter("itemType");

String sql2 = "";

if(rs.next())
{
	rs2 = st2.executeQuery("SELECT cat_id FROM category where cat_name=" + "'" + itemType + "'");
	rs2.next();
	int itemTypeNum = rs2.getInt("cat_id");
	sql2 = "SELECT SUM(maxBid) as totalEarnings FROM(SELECT max(bid_amt) as maxBid FROM bid NATURAL JOIN auction WHERE bid.auction_num = auction.auction_num AND current_timestamp() > auction.end_date AND category="+ "'" + itemTypeNum + "'" + " GROUP BY auction_num) as t1";
}
else
{
	rs2 = st2.executeQuery("SELECT subcat_id FROM subcategory where subcat_name=" + "'" + itemType + "'");
	rs2.next();
	int itemTypeNum = rs2.getInt("subcat_id");
	sql2 = "SELECT SUM(maxBid) as totalEarnings FROM(SELECT max(bid_amt) as maxBid FROM bid NATURAL JOIN auction WHERE bid.auction_num = auction.auction_num AND current_timestamp() > auction.end_date AND subcat="+ "'" + itemTypeNum + "'" + " GROUP BY auction_num) as t1";
}
	
rs = st.executeQuery(sql2);
rs.next();

out.println("The total sales for " + itemType + " is:" + rs.getDouble("totalEarnings"));

con.close();
st.close();
st2.close();
rs.close();
rs2.close();
%>