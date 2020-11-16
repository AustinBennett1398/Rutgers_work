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

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
String x = request.getParameter("auctionnum");
int auctionnum = Integer.parseInt(x);
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
Statement st = con.createStatement();
ResultSet rs;
java.util.Date date = new java.util.Date();
long current = date.getTime();
Timestamp time = new Timestamp(current);
// java.sql.Date currentdate = new java.sql.Date(date.getTime());
// currentdate.setTime(current);
rs = st.executeQuery("select * from auction where auction_num=" + "'" + auctionnum + "'");
// first check if the right auction number was inputted
Statement st1 = con.createStatement();
ResultSet rs1;
rs1 = st1.executeQuery("select COUNT(auction_num) as t1 from auction where auction_num =" + "'" + auctionnum + "'");
rs1.next();
int num = rs1.getInt("t1");
if(num == 0){
	out.println("Please enter a valid auction number <a href='homepage.jsp'>try again</a>");
}else{
	// check if the end date has passed
	rs.next();
	// out.println(rs.getDate("end_date"));
	if(time.before(rs.getDate("end_date"))){
		out.println("Auction is not over yet <a href='homepage.jsp'>try again</a>");
	}else if(time.after(rs.getDate("end_date"))){
		Statement st3 = con.createStatement();
		ResultSet rs3;
		Statement st2 = con.createStatement();
		ResultSet rs2;
		Statement st4 = con.createStatement();
		ResultSet rs4;
		Statement st5 = con.createStatement();
		ResultSet rs5;
		Statement st6 = con.createStatement();
		ResultSet rs6;
		Statement st7 = con.createStatement();
		ResultSet rs7;
		rs2 = st2.executeQuery("select COUNT(username) as hold from bid where auction_num=" + "'" + auctionnum + "'");
		rs2.next();
		int count = rs2.getInt("hold");
		if(count == 0){
			out.println("No one bid on the auction. It is now over. <a href='homepage.jsp'>homepage</a>");
		}else{
			rs3 = st3.executeQuery("select max(bid_amt) from bid where auction_num=" + "'" + auctionnum + "'");
			rs3.next();
			double maxbid = rs3.getDouble("max(bid_amt)");
			rs4 = st4.executeQuery("select * from bid where bid_amt=" + "'" + maxbid + "'" + "and auction_num=" + "'" + auctionnum + "'");
			double secretmin = rs.getDouble("secret_min");
			rs5 = st5.executeQuery("select count(auto_bid) as autobidcount from bid where auction_num=" + "'" + auctionnum + "'");
			rs5.next();
			double autobidcount = rs5.getDouble("autobidcount");
			if((maxbid < secretmin) && (autobidcount == 0)){
				out.println("The auction is over but the highest bid did not meet the secret miniumum set by the seller. Item will go back to seller. <a href='homepage.jsp'>homepage</a>");
			}else{
				if(maxbid > secretmin){
					rs4.next();
					String winner = rs4.getString("username");
					out.println("The winner of the auction is " + winner + "! <a href='homepage.jsp'>homepage</a>");
				}else if((maxbid < secretmin) && (autobidcount != 0)){
					rs6 = st6.executeQuery("select max(auto_bid) from bid where auction_num=" + "'" + auctionnum + "'");
					rs6.next();
					double maxautobid = rs6.getDouble("max(auto_bid)");
					if(maxautobid < secretmin){
						out.println("The auction is over but the highest bid did not meet the secret minimum set by the seller. <a href='homepage.jsp'>homepage</a>");
					}else{
						PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
		 			 	statement.setDouble(1, secretmin);
		 			 	statement.setDouble(2, maxautobid);
		 			 	java.util.Date date1 = new java.util.Date();
		 			 	long current1 = date1.getTime();
		 			 	Timestamp time1 = new Timestamp(current1);
		 			 	statement.setTimestamp(3, time);
		 			 	rs7 = st7.executeQuery("select * from bid where auto_bid=" + "'" + maxautobid + "'" + "and auction_num=" + "'" + auctionnum + "'");
		 			 	rs7.next();
		 			 	String username = rs7.getString("username");
		 			 	statement.setString(4, username);
		 			 	statement.setInt(5, auctionnum);
		 			 	statement.execute();
		 			 	out.println("The winner of the auction is " + username + "! <a href='homepage.jsp'>homepage</a>");
		 			 	rs7.close();
		 			 	statement.close();
					}
					rs6.close();
				}
			}
			rs3.close();
			rs4.close();
			rs5.close();
		}
		st3.close();
		st2.close();
		rs2.close();
		st4.close();
		st5.close();
		st6.close();
		st7.close();
	}
}
con.close();
st.close();
rs.close();
st1.close();
rs1.close();
%>

</body>
</html>