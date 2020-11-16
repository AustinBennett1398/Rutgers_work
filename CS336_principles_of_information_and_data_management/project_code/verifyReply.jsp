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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Forums</title>
</head>
</html>

<%
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
Statement st3 = con.createStatement();
ResultSet rs, rsdate, rssubject;

if(request.getParameter("thread_id") == "" || request.getParameter("content") == "")
{
	out.println("There was an error with the information inputted. <a href='forumReply.jsp'>try again</a>");
}
else
{
	int id = Integer.parseInt(request.getParameter("thread_id"));
	String user = session.getAttribute("user").toString();
	
	rsdate = st2.executeQuery("SELECT current_timestamp() as date");
	rsdate.next();
	String date = rsdate.getString("date");
	
	rssubject = st3.executeQuery("SELECT subject FROM email WHERE id=" + "'" + id + "'");
	if(rssubject.next())
	{
		String subject = rssubject.getString("subject");
		
		rs = st.executeQuery("SELECT * FROM email WHERE id=" + "'" + id + "'");
		if(rs.next())
		{
			PreparedStatement statement = con.prepareStatement("INSERT INTO email VALUES (?, ? , ?, ?, ?)");
			statement.setString(1, user);
			statement.setString(2, subject);
			statement.setString(3, request.getParameter("content"));
			statement.setString(4, date);
			statement.setInt(5, id);
			statement.execute();
			
			out.println("Your answer has been posted! <a href='forums.jsp'>View Forums</a>");
			statement.close();
		}
		else
		{
			out.println("The thread id you entered does not exist <a href='forumReply.jsp'>try again</a>");
		}
		rs.close();
	}
	else
	{
		out.println("The Thread ID you inputted does not exist. <a href='forumReply.jsp'>try again</a>");
	}
	rsdate.close();
	rssubject.close();
}
st.close();
st2.close();
st3.close();
con.close();
%>