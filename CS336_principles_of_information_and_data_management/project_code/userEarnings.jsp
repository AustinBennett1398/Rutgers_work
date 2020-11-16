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
ResultSet rs;

String seller = request.getParameter("seller");
String sql = "SELECT SUM(maxBid) as totalEarnings FROM (SELECT max(bid_amt) as maxBid FROM bid NATURAL JOIN auction WHERE bid.auction_num = auction.auction_num AND current_timestamp() > auction.end_date AND auction.seller="+ "'" + seller + "'" + " GROUP BY auction_num) as t1"; 
rs = st.executeQuery(sql);
rs.next();
Double total_earnings = rs.getDouble("totalEarnings");

if(total_earnings != 0.0)
{
	out.println("Total earnings for (" + seller + "): " + total_earnings);
}
else
{
	out.println("Username you entered was not found or the user has not sold any auctions. <a href='salesReports.jsp'>try again</a>");
}

con.close();
st.close();
rs.close();
%>

</html>