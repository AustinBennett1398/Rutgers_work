<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>

<html>


<div align="right">
<a href="alert.jsp"><button type="button">View Alerts</button></a>
<a href="browse.jsp"><button type="button">Browse Auctions</button></a>
<a href="searchIndex.jsp"><button type="button">Auction Search</button></a>
<a href="forums.jsp"><button type="button">Forums</button></a>
<a href="homepage.jsp"><button type="button">Home</button></a>
</div>

</html>

<%

if(request.getParameter("subcat") == "")
{
	out.println("subcat does not exist, no deletions were made. <a href = 'setalert.jsp'>try again</a>");
}
else
{
	String subcat = request.getParameter("subcat");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st4 = con.createStatement();
	ResultSet rs4;
	rs4 = st4.executeQuery("SELECT DISTINCT cat_name FROM category INNER JOIN subcategory ON category.cat_id IN (SELECT cat_id FROM subcategory WHERE subcat_name=" + "'" + subcat + "'" + ")");
	rs4.next();
	String category = rs4.getString("cat_name");
	String seller = (String) session.getAttribute("user");
		
	Statement st12 = con.createStatement();
	ResultSet rs12;
	rs12 = st12.executeQuery("select max(alert_id) from alert");
	int alert_id = 0;
	if(rs12.first())
	{
		alert_id = rs12.getInt("max(alert_id)");
		alert_id++;
	}
	else
	{
		alert_id = 1;
	}

	PreparedStatement statement1 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
	statement1.setString(1, category);
	statement1.setString(2, subcat);
	statement1.setString(3, "An auction has been posted with a category of: " + "'" + category + "' and a subcategory of: " + "'" + subcat + "'");
	statement1.setInt(4, alert_id);
	statement1.setString(5, seller);
	statement1.setInt(6, 0); 
	statement1.execute();
	
	st12.close();
	rs12.close();
	statement1.close();
	rs4.close();
	st4.close();
	con.close();
	
	out.println("alert has been created");
}
%>

