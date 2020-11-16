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


Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs;


if(request.getParameter("auction_number") == "" || request.getParameter("bid_amt") == "")
{
	out.println("There is an error in the bidding information provided.<a href='editAccount.jsp'>try again</a>");
}
else
{
	Integer aucnum = Integer.parseInt(request.getParameter("auction_number"));
	rs = st.executeQuery("SELECT MAX(date_time) as date FROM bid WHERE username=" + "'" + request.getParameter("username") + "'" + " AND auction_num=" + "'" + aucnum + "'" );
	rs.next();
	if(rs.getString("date") != null)
	{
		String date = rs.getString("date");
		date = date.substring(0, date.length()-2);
		date = date.replace(" ", "T");
		
		Double bid_amt = Double.parseDouble(request.getParameter("bid_amt"));
		out.println(request.getParameter("username"));
		
		int x = st.executeUpdate("UPDATE bid SET bid_amt=" + "'" + bid_amt + "'" + "WHERE username=" + "'" + request.getParameter("username") + "'" + "AND date_time=" + "'" + date + "'" + "AND auction_num =" + "'" + aucnum + "'");
		
		out.println("The bid was successfully updated.");
	}
	else
	{
		out.println("There is an error in the bidding information provided.<a href='editAccount.jsp'>try again</a>");
	}
	rs.close();
}
st.close();
st2.close();
con.close();
%>