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
		out.println("<br><br>Sort by: <select name = \"sortBy\"><br>");
		out.println("<option>--SelectOne--</option><option>Description</option><option>Category</option><option>Subcategory</option><option>Price</option><option>End Date(Latest)</option><option>End Date(Ending Soon)</option></select><br>");
		out.println("Include auctions that have ended: <input type=\"checkbox\" name=\"includeEnded\" value = \"checked\" /> <br>");
		out.println("<br> <input type=\"submit\" value=\"Search\" />");
		out.println("</form>");
		rs.close();
		rs2.close();
		st.close();
		st2.close();
		con.close();
		%>	
   </body>
</html>
