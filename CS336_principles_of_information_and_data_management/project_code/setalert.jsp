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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Auction</title>
</head>
<body>
	<form method="post" action="finishAlert.jsp">
		<table>
			
			
			<%
			Class.forName("com.mysql.jdbc.Driver");
			
			Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
			Statement st2 = con.createStatement();
			Statement st3 = con.createStatement();
			ResultSet rs, rs2, rs3;
			
			String sql2= "SELECT subcat_name FROM subcategory";
			String sql3= "SELECT subcat_id FROM subcategory";
			rs2= st2.executeQuery(sql2);
			rs3= st3.executeQuery(sql3);
			rs3.next();
			int subcatid = rs3.getInt("subcat_id"); 
			
			ArrayList<String> subcategories = new ArrayList<String>();
			while(rs2.next())
			{
				subcategories.add(rs2.getString("subcat_name"));
			}
			
					
			out.println("<td>What is the subcategory: </td><td><select name=\"subcat\">");
			for(int i = 0; i < subcategories.size(); i++)
				out.println("<option>" + subcategories.get(i) + "</option>");
			out.println("</select>");
			
			%>
			
			
		</table>
		<input type="submit" value="Create Alert"/>
	</form>
</body>
</html>