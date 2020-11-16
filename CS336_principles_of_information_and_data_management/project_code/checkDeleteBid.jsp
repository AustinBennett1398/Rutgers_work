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

</html>

<%
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
ResultSet rs;

if(request.getParameter("auction_number") == "")
{
	out.println("There was an error in your input <a href='deleteBid.jsp'>try again</a>");
}
else
{
	int auction_number = Integer.parseInt(request.getParameter("auction_number"));   
	String username = request.getParameter("username");
	rs = st.executeQuery("select * from bid where auction_num=" + auction_number + " AND username=" + "'" + username + "'");
	if(rs.next())
	{
		int i = st.executeUpdate("DELETE FROM bid WHERE auction_num=" + auction_number + " AND username=" + "'" + username + "'");
		out.println("The bid(s) were successfully deleted.");
	}
	else
	{
		out.println("Error. A bid by the specified user on the specified auction does not exist, or the username or auction number are incorrect<br><a href='deleteBid.jsp'>try again</a>");
	}
	rs.close();
}
con.close();
st.close();
%>

