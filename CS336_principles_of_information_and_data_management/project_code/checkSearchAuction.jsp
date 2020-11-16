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

<title>Search Form</title>
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
  border: 1px solid black;
  border-collapse: collapse;
  text-align:center;
}
</style>
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
		ArrayList<String> subcats = new ArrayList<String>();
		subcats.add("--SelectOne--");
		
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
		out.println("Disclaimer: This will show current and past auctions that have expired to see how items have sold in the past.");
		
		%>	
		<h1>Auction Details</h1>
		<%
		String auction_num = request.getParameter("auction_num");
		String query = "SELECT auction_name, auction.auction_num, seller, category, subcat, end_date, description, coalesce(maxBid, start_price) as maxBid FROM(SELECT MAX(bid_amt) as maxBid, auction_num as an " + 
		"FROM bid GROUP BY bid.auction_num) as t right JOIN auction ON an = auction.auction_num where auction.auction_num = " + "'" + auction_num + "'" + " ORDER BY maxBid desc";
		
		
		out.println("<table><tr><th><h3> Auction Name </h3></th><th><h3> Auction Number </h3></th><th><h3> Seller </h3></th><th><h3> End Date </h3></th><th><h3> Category </h3></th><th><h3> Subcategory </h3></th><th><h3> Description </h3></th><th><h3>"
	       		+ " Bid Price </h3></th></tr>");
		
		
		con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
		st = con.createStatement();
		rs = st.executeQuery(query);
		Statement st2 = con.createStatement();
		
		ResultSet rs2 = st2.executeQuery("SELECT MAX(bid_amt) FROM bid WHERE auction_num = '" + auction_num + "'");
		rs2.next();
		double high_bid = rs2.getDouble("MAX(bid_amt)");
		
		
		String a_name, seller, description;
	    int sc_id = -1; 
	    Timestamp a_ts = new Timestamp(System.currentTimeMillis());
	    String subcat = "";
	    while(rs.next())
	    {
	    	 a_name = rs.getString("auction_name");
		  	 seller = rs.getString("seller");
			 sc_id = rs.getInt("subcat");
			 a_ts = rs.getTimestamp("end_date");
			 description = rs.getString("description");
			 high_bid = rs.getDouble("maxBid");
			 
			 rs2 = st2.executeQuery("SELECT cat_name from category where cat_id = '" + rs.getInt("category") + "'");
			 rs2.next();
			 String cat = rs2.getString("cat_name");
			 
			 rs2 = st2.executeQuery("SELECT subcat_name from subcategory where subcat_id = '" + sc_id + "'");
			 rs2.next();
			 subcat = rs2.getString("subcat_name");
			
			
			 out.println("<tr><td>" + a_name + "</td><td>" + auction_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcat + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
			 
				
			// rs2.close();
	    }
		out.println("</table><br>");
		out.println("<h1>Bids</h1>");
		
		query = "select bid_amt, date_time, username from bid where auction_num = " + "'" + auction_num + "'" + "order by bid_amt desc";
		
		out.println("<table><tr><th><h3> Bid Price </h3></th><th><h3> Username </h3></th><th><h3> Date/Time </h3></th></tr>");
		rs = st.executeQuery(query);
		double bid_amt;
		Timestamp b_ts;
		String username;
		while(rs.next())
		{
			bid_amt = rs.getDouble("bid_amt");
			b_ts = rs.getTimestamp("date_time");
			username = rs.getString("username");
			
			out.println("<tr><td>$" + String.format("%.2f", bid_amt) + "</td><td>" + username + "</td><td>" + b_ts + "</td></tr>");
		}
		out.println("</table><br><br><h1> Similar Auctions From the Previous Month </h1>");
		int month = a_ts.getMonth();
		int year = a_ts.getYear();
		Timestamp last_month = new Timestamp(year, month, a_ts.getDay(), a_ts.getHours(), a_ts.getMinutes(), a_ts.getSeconds(), a_ts.getNanos());
		if(month == 0)
		{
			month = 11;
			year--;
		}
		else
			month--;
		last_month.setMonth(month);
		last_month.setYear(year);
		last_month.setDate(a_ts.getDate());
		
		query = "SELECT auction_name, auction.auction_num, seller, category, subcat, end_date, description, coalesce(maxBid, start_price) as maxBid FROM(SELECT MAX(bid_amt) as maxBid, auction_num as an " + 
				"FROM bid GROUP BY bid.auction_num) as t right JOIN auction ON an = auction.auction_num where subcat = " + "'" + sc_id + "'" + " ORDER BY maxBid desc";
		out.println("<table><tr><th><h3> Auction Name </h3></th><th><h3> Auction Number </h3></th><th><h3> Seller </h3></th><th><h3> End Date </h3></th><th><h3> Category </h3></th><th><h3> Subcategory </h3></th><th><h3> Description </h3></th><th><h3>"
	       		+ " Bid Price </h3></th></tr>");
		
		rs = st.executeQuery(query);
		Timestamp newts = a_ts;
		while(rs.next())
		{
			int a_num = rs.getInt("auction.auction_num");
			a_name = rs.getString("auction_name");
		  	seller = rs.getString("seller");
			sc_id = rs.getInt("subcat");
			newts = rs.getTimestamp("end_date");
			description = rs.getString("description");
			//String end_date = rs.getString("end_date");
			
			high_bid = rs.getDouble("maxBid");
			
			rs2 = st2.executeQuery("SELECT cat_name from category where cat_id = '" + rs.getInt("category") + "'");
			rs2.next();
			String cat = rs2.getString("cat_name");
			
			rs2 = st2.executeQuery("SELECT subcat_name from subcategory where subcat_id = '" + sc_id + "'");
			rs2.next();
			String newSubcat = rs2.getString("subcat_name");			
			
			if(newts.before(a_ts) && newts.after(last_month) && newSubcat.equals(subcat))
			{
				out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + newts + "</td><td>" + cat + "</td><td>" + subcat + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
			}
		}		
		out.println("</table>");
		rs.close();
		rs2.close();
		st.close();
		st2.close();
		con.close();
		%>
   </body>
</html>
