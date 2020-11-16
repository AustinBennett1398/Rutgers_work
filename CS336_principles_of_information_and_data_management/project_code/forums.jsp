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
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<body>

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
 /*max-width:2px;
 max-height:10px;*/
 height:100px;
  border: 1px solid black;
  border-collapse: collapse;
  text-align:center;
}
</style>
</head>

<form method="post" action="forums.jsp">
<input type="text" name="tosearch">
<input type="submit" value="search">
</form>

<br>

<form method="post" action="createThread.jsp">
<input type="submit" value="Create New Thread">
</form>
<br>
<%
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;
if (request.getParameter("tosearch") == null || request.getParameter("tosearch") == "")
{
	//ID, Subject, Posted By, Content, Date
	rs = st.executeQuery("SELECT * FROM email ORDER BY ID asc, date_time asc");
	out.println("<table><tr><th><h3> Thread ID </h3></th><th><h3> Subject </h3></th><th><h3> Posted By </h3></th><th><h3> Content </h3></th><th><h3> Date </h3>");
	while(rs.next())
	{
		//out.println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("subject") + "</td><td>" + rs.getString("from") + "</td><td colspan=50>" + rs.getString("content") + "</td><td>" + rs.getString("date_time") + "</td>");
		out.println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("subject") + "</td><td>" + rs.getString("from") + "</td><td rowspan=\"1\">" + rs.getString("content") + "</td><td>" + rs.getString("date_time") + "</td>");
	}
	out.println("</table>");
}
else
{
	rs = st.executeQuery("SELECT * FROM email WHERE subject LIKE" + "'%" + request.getParameter("tosearch") + "%'" + "OR content LIKE" + "'%" + request.getParameter("tosearch") + "%'" + "ORDER BY ID asc, date_time asc");
	rs2 = st2.executeQuery("SELECT * FROM email WHERE content LIKE" + "'%" + request.getParameter("tosearch") + "%'" + "ORDER BY ID asc, date_time asc");
	//out.println("<table><tr><th><h3> Thread ID </h3></th><th><h3> Subject </h3></th><th><h3> Posted By </h3></th><th><h3> Content </h3></th><th><h3> Date </h3>");
	if(rs.next())
	{
		out.println("<table><tr><th><h3> Thread ID </h3></th><th><h3> Subject </h3></th><th><h3> Posted By </h3></th><th><h3> Content </h3></th><th><h3> Date </h3>");
		rs.beforeFirst();		
		while(rs.next())
		{
			out.println("<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("subject") + "</td><td>" + rs.getString("from") + "</td><td>" + rs.getString("content") + "</td><td>" + rs.getString("date_time") + "</td>");
		}
	}
	else
	{
		out.println("No results were found ");
		/*if(rs2.next())
		{
			out.println("<table><tr><th><h3> Thread ID </h3></th><th><h3> Subject </h3></th><th><h3> Posted By </h3></th><th><h3> Content </h3></th><th><h3> Date </h3>");
			rs2.beforeFirst();
			while(rs2.next())
			{
				out.println("<tr><td>" + rs2.getInt("id") + "</td><td>" + rs2.getString("subject") + "</td><td>" + rs2.getString("from") + "</td><td>" + rs2.getString("content") + "</td><td>" + rs2.getString("date_time") + "</td>");
			}
		}
		else
		{
			 //out.println("No results were found <a href='forums.jsp'>try again</a>");
					 out.println("No results were found ");
		}*/
	}
	rs2.close();
}
rs.close();
con.close();
st.close();
st2.close();

%>


</body>
</html>