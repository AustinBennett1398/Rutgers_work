   
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

<title>Search Results</title>


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
<h1>Search:</h1>
	<% 
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st = con.createStatement();
	Statement st2 = con.createStatement();
	ResultSet rs, rs2;
	
		
	String sql = "SELECT cat_name FROM category";
	String sql2= "SELECT subcat_name FROM subcategory";
	rs  = st.executeQuery(sql);
	rs2= st2.executeQuery(sql2);
	
	ArrayList<String> cats = new ArrayList<String>();
	cats.add("--SelectOne--");
	ArrayList<String> subcats = new ArrayList<String>();
	subcats.add("--SelectOne--");
	
	while(rs.next())
	{
		cats.add(rs.getString("cat_name"));
	}
	while(rs2.next())
	{
		subcats.add(rs2.getString("subcat_name"));
	}
	out.println("<form method=\"post\" action=\"checkSearchProduct.jsp\">");
	out.println("Description: <input type=\"text\" name=\"desc\" /> <br>");
	out.println("Category: <select name = \"category\">");
	for(int i = 0; i < cats.size(); i++)
		out.println("<option>" + cats.get(i) + "</option>");
	out.println("</select><br>");
	out.println("Subcategory: <select name = \"subcategory\">");
	for(int i = 0; i < subcats.size(); i++)
		out.println("<option>" + subcats.get(i) + "</option>");
	out.println("</select><br>");
	out.println("Price Max: <input type=\"number\" name=\"max\" min=\"0\" max= \"999999999999999999999\" />");
	out.println("<br><br>Sort by: <select name = \"sortBy\">");
	out.println("<option>--SelectOne--</option><option>Description</option><option>Category</option><option>Subcategory</option><option>Price</option><option>End Date(Latest)</option><option>End Date(Ending Soon)</option></select><br>");
	out.println("Include auctions that have ended: <input type=\"checkbox\" name=\"includeEnded\" value = \"checked\" /> <br>");
	out.println("<br><input type=\"submit\" value=\"Search\" /><br>");
	out.println("</form>");
	%>
<h1>Search Results:</h1>	    
<%
	String desc = request.getParameter("desc");
    String cat = request.getParameter("category");
    String subcat = request.getParameter("subcategory");
    String max_price = request.getParameter("max");
    String subcat_name = request.getParameter("subcat_name");
    String sortBy = request.getParameter("sortBy");
	String checked = request.getParameter("includeEnded");
	
    Class.forName("com.mysql.jdbc.Driver");
    con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
    st = con.createStatement();
    st2 = con.createStatement();
    
    if(desc == null)
    	desc = "";
    
    boolean hasCat = false;
    boolean hasSubCat = false;
    boolean hasMaxPrice = false;
    boolean hasDesc = false;
    boolean hasSort = false;
	boolean isChecked = false;
    
    int catID = -1;
    int subCatID = -1;
    double maxPrice = -1;
    if (!(cat.equals("--SelectOne--")))
    {
    	hasCat = true;
    	rs = st.executeQuery("SELECT * FROM category where cat_name = '" + cat + "'");
    	rs.next();
    	catID = rs.getInt("cat_id");
    	rs.close();
    }
    
    if(!(subcat.equals("--SelectOne--")))
    {
    	hasSubCat = true;
    	rs = st.executeQuery("SELECT subcat_ID FROM subcategory where subcat_name = '" + subcat + "'");
    	rs.next();
    	subCatID = rs.getInt("subcat_id");
    	rs.close();
    	
    }
    if(!(max_price.equals("")))
    {
    	hasMaxPrice = true;
    	maxPrice = Double.parseDouble(max_price);
    }
    if (!(sortBy.equals("--SelectOne--")))
    {
    	hasSort = true;
    }
	if(checked != null)
	{
    	isChecked = true;
    }
	
    String concat = "select subcat_name, auction_name, maxBid, auction_num, seller, category, subcat, end_date, description " + 
    		"from " +
    			"(SELECT auction_name, auction.auction_num, seller, category, subcat, end_date, description, coalesce(maxBid, start_price) as maxBid " +
     	  	 	"FROM " +
    				"(SELECT MAX(bid_amt) as maxBid, auction_num as an FROM bid GROUP BY bid.auction_num) as t right JOIN auction ON an = auction.auction_num) " +
     	  	 			"as k left join subcategory on subcat = subcategory.subcat_id ";
    int counter = 0;
    			
    if(hasCat)
    {
    	String condition = " category = " + "'" + catID + "'";
    	if(counter == 0)
    	{
    		concat += "where " + condition;
    		counter++;
    	}
    	else concat += "and " + condition;
    }
    if(hasSubCat)
    {
    	String condition = " subcat =" + "'" + subCatID + "'";
    	if(counter == 0)
    	{
    		concat += "where " + condition;
    		counter++;
    	}
    	else concat += "and " + condition;
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
	     subcategory_name = rs.getString("subcat_name");
	  	 seller = rs.getString("seller");
		 sc_id = rs.getInt("subcat");
		 a_num = rs.getInt("auction_num");
		 a_ts = rs.getTimestamp("end_date");
		 description = rs.getString("description");

		 
		 double high_bid = rs.getDouble("maxBid");
		 
		 rs2 = st2.executeQuery("SELECT cat_name from category where cat_id = '" + rs.getInt("category") + "'");
		 rs2.next();
		 cat = rs2.getString("cat_name");
		
		 if(!hasSubCat)
		 {	
			  rs2 = st2.executeQuery("select subcat_name from subcategory where subcat_id = '" + sc_id + "'");
			  rs2.next();
			  subcat = rs2.getString("subcat_name");  
		 }	
					
		 if(hasMaxPrice)			
	     {
	    	  if(maxPrice >= high_bid && ts.before(a_ts) && description.indexOf(desc) != -1 && isChecked == false)
	    	  {
	    		   out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcategory_name + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
	    	  }
	    	  else if(maxPrice >= high_bid && description.indexOf(desc) != -1 && isChecked == true)
	    	  {
				   out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcategory_name + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
	    	  }
	     }
		 else 
			 if(ts.before(a_ts) && description.indexOf(desc) != -1 && isChecked == false)
		 	 {
			  	out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcategory_name + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
			 }
			 else if(description.indexOf(desc) != -1 && isChecked == true)
			 {
				 out.println("<tr><td>" + a_name + "</td><td>" + a_num + "</td><td>" + seller + "</td><td>" + a_ts + "</td><td>" + cat + "</td><td>" + subcategory_name + "</td><td>" + description + "</td><td>$" + String.format("%.2f", high_bid) + "</td></tr>");
			 }
			
		 rs2.close();
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