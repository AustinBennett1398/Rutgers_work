<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>


<%
String username = request.getParameter("usr");
String new_pwd = request.getParameter("pwd");

Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
ResultSet rs;
rs = st.executeQuery("select * from user where username=" + "'" + username + "'");
if(rs.next() && new_pwd.length() <= 45 && new_pwd.length() > 0)
{
	int i = st.executeUpdate("UPDATE user SET password=" + "'" + new_pwd + "'" + "WHERE username=" + "'" + username + "'");
	out.println("Account password has been successfully changed.");
}
else
{
	out.println("Either the username does not exist or password requirements were not met.<a href='editAccount.jsp'>try again</a>");
}

con.close();
st.close();
rs.close();

			
%>