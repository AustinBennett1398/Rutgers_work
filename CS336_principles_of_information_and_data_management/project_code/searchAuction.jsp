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
	<h1>Search Auction:</h1>
		<% 
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
		Statement st = con.createStatement();
		ResultSet rs;
		
			
		String sql = "SELECT auction_num FROM auction";
		rs  = st.executeQuery(sql);
		
		ArrayList<Integer> auctionNums = new ArrayList<Integer>();
				
		while(rs.next())
		{
			auctionNums.add(rs.getInt("auction_num"));
		}
		out.println("<form method=\"post\" action=\"checkSearchAuction.jsp\">");
		out.println("Auction Number: <select name = \"auction_num\">");
		for(int i = 0; i < auctionNums.size(); i++)
			out.println("<option>" + auctionNums.get(i) + "</option>");
		out.println("</select><br>");
		out.println("<br> <input type=\"submit\" value=\"Search\" />");
		out.println("</form>");
		out.println("Disclaimer: This will show auctions that are still going on and auctions that are over.");
		rs.close();
		st.close();
		con.close();
		%>	
   </body>
</html>
