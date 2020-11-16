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

if(request.getParameter("auction_number") == "")
{
	out.println("The auction you are attempting to edit does not exist.<a href='editAccount.jsp'>try again</a>");
}
else
{
	int auction_number = Integer.parseInt(request.getParameter("auction_number"));   
	//session.setAttribute("auction_number", auction_number);
	//session.setAttribute(request.getParameter("auction_number"), "auction_number");
	//out.println("The session atrb: " + session.getAttribute("auction_number"));
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
	Statement st = con.createStatement();
	ResultSet rs;
	rs = st.executeQuery("select * from auction where auction_num=" + auction_number);
	if(rs.next())
	{
		Statement fst = con.createStatement();
		Statement scnd = con.createStatement();
		ResultSet catRS = fst.executeQuery("SELECT cat_name FROM category");
		ResultSet subcatRS = scnd.executeQuery("SELECT subcat_name FROM subcategory");

		ArrayList<String> categories = new ArrayList<String>();
		ArrayList<String> subcategories = new ArrayList<String>();
		while(catRS.next())
		{
			categories.add(catRS.getString("cat_name"));
		}
		while(subcatRS.next())
		{
			subcategories.add(subcatRS.getString("subcat_name"));
		}
		
		out.println("<form method=\"post\" action=\"updateAuction.jsp\">");
		out.println("Auction Name: <input id=\"an\" type=\"text\" name=\"auction_name\"> <br>");
		out.println("Minimum Increment: <input id=\"mi\" type=\"number\" name=\"min_inc\" min=0.01 step=0.01> <br>");
		out.println("End Date: <input id=\"ed\" type=\"datetime-local\" name=\"end_date\" step=1> <br>");
		out.println("Secret Minimum: <input id=\"sm\" type=\"number\" name=\"sec_min\" min=0 step=0.01> <br>");
		out.println("Description:  <input id=\"desc\" type=\"text\" name=\"description\"> <br>");
		
		/*out.println("Category: <select name = \"category\">");
		for(int i = 0; i < categories.size(); i++)
			out.println("<option>" + categories.get(i) + "</option>");
		out.println("</select> <br>");*/
		
		out.println("Subcategory: <select name = \"subcategory\">");
		for(int i = 0; i < subcategories.size(); i++)
			out.println("<option>" + subcategories.get(i) + "</option>");
		out.println("</select> <br>");
		out.println("<input type=\"hidden\" value=" + auction_number + " name=\"auction_number\" >");
		out.println("<input type=\"submit\" value=\"Update\">");
		out.println("</form>");
		
		fst.close();
		scnd.close();
		catRS.close();
		subcatRS.close();
		
	}
	else
	{
		out.println("The auction you are attempting to edit does not exist.<a href='editAccount.jsp'>try again</a>");
	}
	con.close();
	st.close();
	rs.close();
}

%>
<html>
<body>
<script>

var myArray = [
<%
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
Statement st2 = con.createStatement();
Statement st3 = con.createStatement();
ResultSet rs,rs2, rs3, rs4;

if(request.getParameter("auction_number") == "")
{
	out.println("The auction you are attempting to edit does not exist.<a href='editAccount.jsp'>try again</a>");
}
else
{
	int auction_number = Integer.parseInt(request.getParameter("auction_number"));   
					
	rs = st.executeQuery("SELECT * FROM auction WHERE auction_num=" + auction_number);
	if(rs.next())
	{
		out.println("\"" + rs.getString("auction_name") + "\"" + ",");
		out.println("\"" + rs.getDouble("min_increment") + "\"" + ",");
		String test = rs.getString("end_date");
		test = test.replace(" ", "T");
		//test = test.substring(0, test.length() - 2);
		out.println("\"" + test + "\"" + ",");
		out.println("\"" + rs.getDouble("secret_min") + "\"" + ",");
		out.println("\"" + rs.getString("description") + "\"" + ",");
						
		/*rs2=st2.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + rs.getInt("category"));
		rs2.next();
		String cat = rs2.getString("cat_name");
		out.println("\"" + cat + "\"" + ",");*/
						
		rs3=st3.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + rs.getInt("subcat"));
		rs3.next();
		String subcat = rs3.getString("subcat_name");
		out.println("\"" + subcat + "\"");
		rs3.close();
		//rs2.close();
	}
	else
	{
		out.println("The auction you are attempting to edit does not exist.<a href='editAccount.jsp'>try again</a>");
	}
					
	rs.close();
	st.close();
	st2.close();
	st3.close();
}
%>
]

var current_time = <%
Statement st4 = con.createStatement();	
rs4 = st4.executeQuery("SELECT current_timestamp() as time");
rs4.next();
String holder = rs4.getString("time");
holder = holder.replace(" ", "T");
out.println("\"" + holder + "\"");
rs4.close();
%>


document.getElementById("an").value = myArray[0];
document.getElementById("mi").value = myArray[1];
document.getElementById("ed").value = myArray[2];
document.getElementById("ed").min = current_time;
document.getElementById("sm").value = myArray[3];
document.getElementById("desc").value = myArray[4];
//document.getElementById("cat").value = myArray[5];
//document.getElementById("sub").value = myArray[6];
document.getElementById("sub").value = myArray[5];


</script>
</body>
</html>

