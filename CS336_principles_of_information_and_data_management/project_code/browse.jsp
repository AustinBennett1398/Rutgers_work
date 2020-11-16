   
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html>
<html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<title>Browse</title>


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
<h1>Browse:</h1>
	<% 
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st = con.createStatement();
	Statement st2 = con.createStatement();
	ResultSet rs, rs2;
	
		
	String concat = "select subcat_name, auction_name, maxBid, auction_num, seller, category, subcat, end_date, description " + 
    		"from " +
    			"(SELECT auction_name, auction.auction_num, seller, category, subcat, end_date, description, coalesce(maxBid, start_price) as maxBid " +
     	  	 	"FROM " +
    				"(SELECT MAX(bid_amt) as maxBid, auction_num as an FROM bid GROUP BY bid.auction_num) as t right JOIN auction ON an = auction.auction_num) " +
     	  	 			"as k left join subcategory on subcat_id = subcat";

	rs  = st.executeQuery(concat);
	
	
	
	
	out.println("<form method=\"post\" action=\"browse.jsp\">");
	out.println("Sort by: <select name = \"sortBy\">");
	out.println("<option>--SelectOne--</option><option>Description</option><option>Category</option><option>Subcategory</option><option>Price</option><option>End Date(Latest)</option><option>End Date(Ending Soon)</option><br>");
	out.println("<br><input type=\"submit\" value=\"Search\" /><br>");
	out.println("</form>");
	out.println("Note: Browsing only shows ongoing auctions.<br><br>");
	
    String sortBy = request.getParameter("sortBy");

    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
    st = con.createStatement();
    st2 = con.createStatement();
    
    boolean hasSort = false;
    
    if (sortBy != null)
    {
    	hasSort = true;
    }
    
    if(hasSort)
    {
    	String condition = " order by ";
    	if(sortBy.equals("Description"))
    		condition += "description";
    	else if(sortBy.equals("Category"))
    		condition += "category";
    	else if(sortBy.equals("Subcategory"))
    		condition += "subcat_name";
    	else if(sortBy.equals("End Date(Latest)"))
    		condition += "end_date desc";
    	else if(sortBy.equals("End Date(Ending Soon)"))
    		condition += "end_date";
    	else if(sortBy.equals("Price"))
    		condition += "maxBid";
    	concat += condition;
    }
    out.println("<table><tr><th><h3> Auction Name </h3></th><th><h3> Auction Number </h3></th><th><h3> Seller </h3></th><th><h3> End Date </h3></th><th><h3> Category </h3></th><th><h3> Subcategory </h3></th><th><h3> Description </h3></th><th><h3>"
       		+ " Bid Price </h3></th></tr>");
    Timestamp ts = new Timestamp(System.currentTimeMillis());
    rs = st.executeQuery(concat);
    String a_name, seller, description, subcategory_name;
    int a_num, sc_id; 
    Timestamp a_ts;
    while(rs.next())
    {
    	 
	     a_name = rs.getString("auction_name");
	     //subcategory_name = rs.getString("subcat_name");
	  	 seller = rs.getString("seller");
		 sc_id = rs.getInt("subcat");
		 a_num = rs.getInt("auction_num");
		 a_ts = rs.getTimestamp("end_date");
		 description = rs.getString("description");

		 
		 double high_bid = rs.getDouble("maxBid");
		 
		 rs2 = st2.executeQuery("SELECT cat_name from category where cat_id = '" + rs.getInt("category") + "'");
		 rs2.next();
		 String cat = rs2.getString("cat_name");
		
		 rs2 = st2.executeQuery("select subcat_name from subcategory where subcat_id = '" + sc_id + "'");
		 rs2.next();
		 String subcat = rs2.getString("subcat_name");  
	
				
		 if(ts.before(a_ts))
		 {
			  out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcat + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
		 }
			
		 rs2.close();
    }
    out.println("</table>");
    
    rs.close();
    st.close();
    st2.close();
    con.close();
    
   
%>

</body>
</html>