<%@ page import ="java.sql.*" %>

<html>
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
    if(pwd.length() > 45)
    	out.println("Password cannot exceed 45 characters <a href='createAccount.jsp'>try again</a>");
    else if(userid.length() > 45)
    	out.println("Username cannot exceed 45 characters <a href='createAccount.jsp'>try again</a>");
    else if (!(rs.next())) {
    	PreparedStatement statement = con.prepareStatement("INSERT INTO user (username, password, access_level) VALUES ( ?, ?, 1)");
    	statement.setString(1, userid);
    	statement.setString(2, pwd );
    	statement.execute();
  	   // rs = st.executeQuery("insert into user values (" + userid + "," + pwd + ", 0)"); 
        out.println("Account created: " + userid);
        out.println("<a href='login.jsp'>Log in</a>");
       // response.sendRedirect("success.jsp");
       statement.close();
    } else {
        out.println("Username is already taken <a href='createAccount.jsp'>try again</a>");
    }
    
    con.close();
    st.close();
    rs.close();
%>