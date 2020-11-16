<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<%

if(request.getParameter("acutionname") == "")
{
	out.println("Auction name does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
	
}
else if(request.getParameter("min_increment") == "")
{
	out.println("minimum increment does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else if(request.getParameter("end_date") == "")
{
	out.println("End date does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else if(request.getParameter("secret_min") == "")
{
	out.println("secret minimum does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else if(request.getParameter("start_price") == "")
{
	out.println("start price does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else if(request.getParameter("description") == "")
{
	out.println("description does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else if(request.getParameter("subcat") == "")
{
	out.println("subcategory does not exist, no auctions were made. <a href = 'createAuction.jsp'>try again</a>");
}
else
{
	String auctionname = request.getParameter("auction_name");
	String minincrement = request.getParameter("min_increment");
	double a = Double.parseDouble(minincrement);
	String enddate = request.getParameter("end_date");
	String time = ":00";
	//out.println(enddate);
	String secretmin = request.getParameter("secret_min");
	double c = Double.parseDouble(secretmin);
	String startprice = request.getParameter("start_price");
	double d = Double.parseDouble(startprice);
	String description = request.getParameter("description");
	
	
	//String category = request.getParameter("category");
	//out.println(category);
	String subcat = request.getParameter("subcat");
	//out.println(subcat);
	String seller = (String) session.getAttribute("user");
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st = con.createStatement();
	ResultSet rs;
	
	Statement st2 = con.createStatement();
	ResultSet rs2;
	
	rs2 = st2.executeQuery("select subcat_id from subcategory where subcat_name=" + "'" + subcat + "'");
	Statement st1 = con.createStatement();
	ResultSet rs1;
	int catid;
	int subcatid;
	
	rs2.first();
	subcatid = rs2.getInt("subcat_id");
	
	Statement st3 = con.createStatement();
	ResultSet rs4;
	rs4 = st3.executeQuery("SELECT DISTINCT cat_name FROM category INNER JOIN subcategory ON category.cat_id IN (SELECT cat_id FROM subcategory WHERE subcat_id=" + "'" + subcatid + "'" + ")");
	rs4.next();
	String category1 = rs4.getString("cat_name");
	
	rs1 = st1.executeQuery("select cat_id from category where cat_name=" + "'" + category1 + "'");
	rs1.first();
	catid = rs1.getInt("cat_id");
	
	rs = st.executeQuery("select max(auction_num) from auction");
	int auctionnum = 0;
	
	if(rs.first())
	{
		auctionnum = rs.getInt("max(auction_num)");
		auctionnum++;
	}
	else
	{
		auctionnum = 1;
	}
	
	int valid = 0;
	Statement ct3 = con.createStatement();
	
	Statement st4 = con.createStatement();
	ResultSet rs45;
	rs45 = st4.executeQuery("SELECT DISTINCT cat_name FROM category INNER JOIN subcategory ON category.cat_id IN (SELECT cat_id FROM subcategory WHERE subcat_name=" + "'" + subcat + "'" + ")");
	rs45.next();
	String category2 = rs45.getString("cat_name");
	
	
	st.executeUpdate("update alert set valid=1 where cat_name=" + "'" + category2 + "'" + "and subcat_name=" + "'" + subcat + "'" + "and valid=" + valid + " and not username=" + "'" + seller + "'");
	
	
	st4.close();
	rs45.close();
	
	PreparedStatement statement = con.prepareStatement("insert into auction (auction_name, auction_num, min_increment, seller, end_date, secret_min, start_price, description, category, subcat) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
	statement.setString(1, auctionname);
	statement.setInt(2, auctionnum);
	statement.setDouble(3, a);
	statement.setString(4, seller);
	statement.setString(5, enddate);
	statement.setDouble(6, c);
	statement.setDouble(7, d);
	statement.setString(8, description);
	statement.setInt(9, catid);
	statement.setInt(10, subcatid);
	statement.execute();
	rs.close();
	rs1.close();
	rs2.close();
	ct3.close();
	st.close();
	statement.close();
	con.close();
	st3.close();
	st2.close();
	
	out.println("Auction has been created");
}
%>
