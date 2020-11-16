<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forums</title>
</head>

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
ResultSet rs;

if(request.getParameter("content") == "" || request.getParameter("subject") == "")
{
	out.println("Either you did not enter a message or you did not enter a subject. <a href='createThread.jsp'>try again</a>");
}
else
{
	rs = st.executeQuery("SELECT MAX(id) as max FROM email");
	rs.next();
	int new_id = rs.getInt("max")+1;
	
	rs = st2.executeQuery("SELECT current_timestamp() as date");
	rs.next();
	String date = rs.getString("date");
	
	PreparedStatement statement = con.prepareStatement("INSERT INTO email VALUES(?, ?, ?, ?, ?)");
	statement.setString(1, session.getAttribute("user").toString());
	statement.setString(2, request.getParameter("subject"));
	statement.setString(3, request.getParameter("content"));
	statement.setString(4, date);
	statement.setInt(5, new_id);
	statement.execute();
	
	out.println("Thread successfully created.");
	
	rs.close();
}

st.close();
st2.close();
con.close();
%>
