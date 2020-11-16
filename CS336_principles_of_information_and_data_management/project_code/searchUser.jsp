<%@ page import ="java.sql.*" %>
<%@ page import ="java.util.*" %>
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
<title>Search Form</title>
</head>
	<body>
	<h1>Search User:</h1>
		<% 
		
		out.println("<form method=\"post\" action=\"checkSearchUser.jsp\">");
		out.println("User: <input type=\"text\" name=\"username\" /> <br>");
		out.println("Include auctions that have ended: <input type=\"checkbox\" name=\"includeEnded\" value = \"checked\" /> <br>");
		out.println("<br> <input type=\"submit\" value=\"Search\" />");
		out.println("</form>");
		%>	
   </body>
</html>
