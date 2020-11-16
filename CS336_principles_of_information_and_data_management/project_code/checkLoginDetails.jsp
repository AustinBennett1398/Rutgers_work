<%@ page import ="java.sql.*" %>
<%
    String userid = request.getParameter("username");   
    String pwd = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select access_level from user where username='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid); // the username will be stored in the session
        session.setAttribute("access_level", rs.getInt(1));
        response.sendRedirect("homepage.jsp");
    } else {
        out.println("Invalid username or password <a href='login.jsp'>try again</a>");
    }
    con.close();
    st.close();
    rs.close();
%>