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
	<h1>Search User:</h1>
		<% 
		out.println("<form method=\"post\" action=\"checkSearchUser.jsp\">");
		out.println("User: <input type=\"text\" name=\"username\" /> <br>");
		out.println("Include auctions that have ended: <input type=\"checkbox\" name=\"includeEnded\" value = \"checked\" /> <br>");
		out.println("<br> <input type=\"submit\" value=\"Search\" />");
		out.println("</form>");
			
		
		out.println("<h1>Auctions Created by User</h1>");
		String username = request.getParameter("username");
		String checked = request.getParameter("includeEnded");
		
		String query = "SELECT auction_name, auction.auction_num, seller, category, subcat, end_date, description, coalesce(maxBid, start_price) as maxBid FROM(SELECT MAX(bid_amt) as maxBid, auction_num as an " + 
				"FROM bid GROUP BY bid.auction_num) as t right JOIN auction ON an = auction.auction_num where seller = " + "'" + username + "'" + " ORDER BY end_date";

		boolean isChecked = false;
		if(checked != null)
		{
	    	isChecked = true;
	    }
		
		out.println("<table><tr><th><h3> Auction Name </h3></th><th><h3> Auction Number </h3></th><th><h3> Seller </h3></th><th><h3> End Date </h3></th><th><h3> Category </h3></th><th><h3> Subcategory </h3></th><th><h3> Description </h3></th><th><h3>"
	       		+ " Bid Price </h3></th></tr>");
		
		Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		Statement st2 = con.createStatement();
		ResultSet rs2 = st2.executeQuery("SELECT * from auction");
		
		String a_name, seller, description, auction_num;
	    int sc_id; 
	    Timestamp a_ts;
	    while(rs.next())
	    {
			 auction_num = rs.getString("auction_num");
	    	 a_name = rs.getString("auction_name");
			 sc_id = rs.getInt("subcat");
			 a_ts = rs.getTimestamp("end_date");
			 description = rs.getString("description");
			 
			 
			 double high_bid = rs.getDouble("maxBid");
			 
			 rs2 = st2.executeQuery("SELECT cat_name from category where cat_id = '" + rs.getInt("category") + "'");
			 rs2.next();
			 String cat = rs2.getString("cat_name");
			 
			 rs2 = st2.executeQuery("SELECT subcat_name from subcategory where subcat_id = '" + sc_id + "'");
			 rs2.next();
			 String subcat = rs2.getString("subcat_name");
			
			if(isChecked)
			 	out.println("<tr><td>" + a_name + "</td><td>" + auction_num + "</td><td>" + username + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcat + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
			else if(a_ts.after(new Timestamp(System.currentTimeMillis())))
				out.println("<tr><td>" + a_name + "</td><td>" + auction_num + "</td><td>" + username + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcat + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
				
				
			 rs2.close();
	    }
		out.println("</table><br>");
		out.println("<h1>Bids by User:</h1>");
		query = "select bid_amt, date_time, auction_num from bid where username = " + "'" + username + "'" + "order by date_time desc";
		
		out.println("<table><tr><th><h3> Bid Price </h3></th><th><h3> Auction Number </h3></th><th><h3> Date/Time </h3></th></tr>");
		rs = st.executeQuery(query);
		double bid_amt;
		Timestamp b_ts;
		while(rs.next())
		{
			bid_amt = rs.getDouble("bid_amt");
			b_ts = rs.getTimestamp("date_time");
			auction_num = rs.getString("auction_num");
			
			out.println("<tr><td>$" + String.format("%.2f", bid_amt) + "</td><td>" + auction_num + "</td><td>" + b_ts + "</td></tr>");
		}
		
		
		rs.close();
		rs2.close();
		st.close();
		st2.close();
		con.close();
		%>
   </body>
</html>
