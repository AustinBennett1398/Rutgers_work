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

</html>

<%
if(request.getParameter("auction_number") == "")
{
	out.println("Auction number does not exist, no deletions were made.<a href='deleteAuction.jsp'>try again</a>");
}
else
{
	int auction_number = Integer.parseInt(request.getParameter("auction_number"));   
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from auction where auction_num=" + auction_number);
	if(rs.next())
	{
		int i = st.executeUpdate("DELETE FROM auction WHERE auction_num=" + auction_number);
		out.println("The auction was successfully deleted.");
	}
	else
	{
		out.println("Auction number does not exist, no deletions were made.<a href='deleteAuction.jsp'>try again</a>");
	}
	
	con.close();
	st.close();
	rs.close();
}
%>

