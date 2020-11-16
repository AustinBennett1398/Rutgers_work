<%@ page import ="java.sql.*" %>
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
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from user where username='" + userid + "'");
    //out.println(rs.next());
    if(pwd.length() > 45 || userid.length() > 45 || pwd.length() < 8 || userid.length() == 0)
    {
    	out.println("The username or password entered does not meet the requirements of account creation.<a href='createCR.jsp'>try again</a>");
    }
    else if (!(rs.next())) 
    {
    	PreparedStatement statement = con.prepareStatement("INSERT INTO user (username, password, access_level) VALUES ( ?, ?, 2)");
    	statement.setString(1, userid);
    	statement.setString(2, pwd );
    	statement.execute();
        out.println("Account created: " + userid);
        statement.close();
    } 
    else 
    {
        out.println("Username is already taken <a href='createCR.jsp'>try again</a>");
    }
    
    con.close();
    st.close();
    rs.close();
%>