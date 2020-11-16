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
</div>iv>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction</title>
</head>
<body>
	<form method="post" action="addAuction.jsp">
		<table>
			<tr>
			<td>What is your auction title: </td><td><input name="auction_name" type="text"></td>
			</tr>
			<tr>
			<td>What is the end date for auction?: </td><td><input name="end_date" type="datetime-local"></td>
			</tr>
			<tr>
			<td>What is your secret minimum bid?: </td><td><input name="secret_min" type="text"></td>
			</tr>
			<tr>
			<td>What is the minimum bidding increment?: </td><td><input name="min_increment" type="text"></td>
			</tr>
			<tr>
			<td>What is the start price?: </td><td><input name="start_price" type="text"></td>
			</tr>
			<tr>
			<td>Specify a description for your auction: </td><td><input name="description" type="text"></td>
			</tr>
			<tr>
			
			<%
			
			Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
			Statement st2 = con.createStatement();
			ResultSet rs2;
			
			String sql2= "SELECT subcat_name FROM subcategory";
			rs2= st2.executeQuery(sql2);
			
			ArrayList<String> subcategories = new ArrayList<String>();
			while(rs2.next())
			{
				subcategories.add(rs2.getString("subcat_name"));
			}
			
			
			out.println("<td>What is the subcategory: </td><td><select name=\"subcat\">");
			for(int i = 0; i < subcategories.size(); i++)
				out.println("<option>" + subcategories.get(i) + "</option>");
			out.println("</select>");
			
			st2.close();
			con.close();
			rs2.close();
			%>
			
		</table>
		<input type="submit" value="Create Auction"/>
	</form>
</body>
</html>