<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

<body>
<form method="post" action="totalEarnings.jsp">
<input type="submit" value="Total Earnings" />
</form>

<form method="post" action="userEarnings.jsp">
<input type="text" name="seller" maxlength=44>
<input type="submit" value="User Earnings" />
</form>


<% 
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;

String sql = "SELECT cat_name FROM category";
String sql2= "SELECT subcat_name FROM subcategory";
rs  = st.executeQuery(sql);
rs2= st2.executeQuery(sql2);

ArrayList<String> itemTypes = new ArrayList<String>();
while(rs.next())
{
	itemTypes.add(rs.getString("cat_name"));
}
while(rs2.next())
{
	itemTypes.add(rs2.getString("subcat_name"));
}

out.println("<form method=\"post\" action=\"itemEarnings.jsp\">");
out.println("Item Type: <select name = \"itemType\">");
for(int i = 0; i < itemTypes.size(); i++)
	out.println("<option>" + itemTypes.get(i) + "</option>");
out.println("</select>");
out.println("<input type=\"submit\" value=\"Item Earnings\" />");
out.println("</form>");


con.close();
st.close();
st2.close();
rs.close();
rs2.close();
%>

<form method="post" action="bestSellers.jsp">
<input type="submit" value="Best Sellers" />
</form>

<form method="post" action="bestBuyers.jsp">
<input type="submit" value="Best Buyers" />
</form>

</body>
</html>
