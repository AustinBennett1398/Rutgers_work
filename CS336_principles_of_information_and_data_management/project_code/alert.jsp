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

<title>Alert Results</title>
<head>
<style>
table
{
width:100%
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

<body>
<%
String username = (String)session.getAttribute("user");

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");

Statement st = con.createStatement();
ResultSet rs = st.executeQuery("select * from alert where username = '" + username + "'" + "and valid=\"1\"");


out.println("<table><tr><th><h3> Category </h3></th><th><h3> Subcategory </h3></th><th><h3> Description </h3></th><th><h3> Alert ID </h3></th><th><h3> Username </h3></th></tr>");


while(rs.next())
{
	String category = rs.getString("cat_name");
	String subcat = rs.getString("subcat_name");
	String description = rs.getString("description");
	int alert_id = rs.getInt("alert_id");
	String username1 = rs.getString("username");
	
	
	out.println("<tr><td>" + category + "</td><td>" + subcat + "</td><td>" + description + "</td><td>" + alert_id + "</td><td>" + username1 + "</td></tr>"); 
}
rs.close();
st.close();
out.println("</table");
con.close();


%>
</body>
</html>