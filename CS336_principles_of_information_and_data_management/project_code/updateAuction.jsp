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

</html>

<%


Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
ResultSet rs, rs2;

//get integer values for cat and subcat
/*rs = st.executeQuery("SELECT cat_id FROM category WHERE cat_name=" +  "\"" + request.getParameter("category") + "\"");
rs.next();
int cat_id = rs.getInt("cat_id");*/

rs = st.executeQuery("SELECT cat_id FROM subcategory WHERE subcat_name=" +  "\"" + request.getParameter("subcategory") + "\"");
rs.next();
int cat_id = rs.getInt("cat_id");

rs2 = st2.executeQuery("SELECT subcat_id FROM subcategory WHERE subcat_name=" +  "\"" + request.getParameter("subcategory") + "\"");
rs2.next();
int subcat_id = rs2.getInt("subcat_id");
//
PreparedStatement statement = con.prepareStatement("UPDATE auction SET auction_name = ?, min_increment = ?, end_date = ?, secret_min = ?, description = ?, category = ?, subcat = ? WHERE auction_num = ?");
statement.setString(1, request.getParameter("auction_name"));
statement.setDouble(2, Double.parseDouble(request.getParameter("min_inc")));
statement.setString(3, request.getParameter("end_date"));
statement.setDouble(4, Double.parseDouble(request.getParameter("sec_min")));
statement.setString(5, request.getParameter("description"));
statement.setInt(6, cat_id);
statement.setInt(7, subcat_id);
statement.setInt(8, Integer.parseInt(request.getParameter("auction_number")));
int rowAffected = statement.executeUpdate();

statement.close();
st.close();
st2.close();
rs.close();
rs2.close();
con.close();

out.println("The auction has been successfully updated");
//out.println(rowAffected);

//session.removeAttribute("auction_number");



%>