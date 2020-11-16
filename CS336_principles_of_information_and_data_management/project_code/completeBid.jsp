<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.Date" %>
<%@ page import="java.sql.Timestamp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <%
 		
 //public void placeBid(double bid_amt, double auto_bid, Timestamp date_time, String username, int auction_num){
		 
 //}
 String x = request.getParameter("test");
 
 //out.println(x);
 boolean validbidamt = true;
 double inputbidamt = 0;
 if(!request.getParameter("bid_amt").isEmpty()){
	 inputbidamt = Double.parseDouble(request.getParameter("bid_amt"));
 }else{
	 validbidamt = false;
 }
 
 boolean validautobid = true;
 double autobid = 0;
 if(!request.getParameter("autobid").isEmpty()){
	 autobid = Double.parseDouble(request.getParameter("autobid"));
 }else{
	 validautobid = false;
 }
 if((x == "") && (request.getParameter("bid_amt") == "") && (request.getParameter("autobid") == "")){
	 out.println("Please enter input <a href='bid.jsp'>try again</a>");
 }else{
 int auctionnum = Integer.parseInt(x);
 
  
 
 Class.forName("com.mysql.jdbc.Driver");
 Connection con = DriverManager.getConnection("jdbc:mysql://cs336-database.cfkmnmfusmeh.us-east-2.rds.amazonaws.com:3306/BuyMe","notbrett", "giveusanA");
 Statement st = con.createStatement();
 ResultSet rs;
 rs = st.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
 double minincrement = 0;
 Statement temp = con.createStatement();
 ResultSet hold;
 hold = temp.executeQuery("select COUNT(auction_num) as t1 from auction where auction_num =" + "'" + auctionnum + "'");
 hold.next();
 int count1 = hold.getInt("t1");
 //out.println("count1:");
 //out.println(count1);
 
 if(count1 == 0){
	 //out.println("HELLO");
	 out.println("Please enter a valid auction number <a href='bid.jsp'>try again</a>");
 }else{
 rs.next();
 // checking if the auction is not over and that a user is not placing bid on own auction.
 String ogusername = (String)session.getAttribute("user");
 if(ogusername.equals(rs.getString("seller"))){
	 out.println("You can't place a bid on your own auction... <a href='bid.jsp'>try again</a>");
 }else{
 //java.util.Date date5 = new java.util.Date();
 //java.sql.Date currentdate = new java.sql.Date(date5.getTime());
 java.util.Date date55 = new java.util.Date();
 long current55 = date55.getTime();
 Timestamp time55 = new Timestamp(current55);
 if(time55.after(rs.getTimestamp("end_date"))){
	 out.println("Auction is over, you can no longer place bids. <a href='bid.jsp'>try again</a>");
 }else{
 minincrement = rs.getDouble("min_increment");
 Statement st1 = con.createStatement();
 ResultSet rs1;
 rs1 = st1.executeQuery("select max(bid_amt) from bid where auction_num =" + "'" + auctionnum + "'");
 
 //rs1.next();
 double maxbid = 0;
 double newminbid = 0;
 //while(rs1.next()){
	 //out.println("loop");
 //}
 
 Statement z = con.createStatement();
 ResultSet y = z.executeQuery("SELECT COUNT(auction_num) as numBids FROM bid WHERE auction_num=" + auctionnum);
 y.next();
 int poo = y.getInt("numBids");
 //if(poo == 0)
 //out.println("poo: ");
 //out.println(poo);
 // MARK CHANGED THIS FROM IF RS1.FIRST() && POO != 0
 boolean alert = true;
 if(poo > 0){
	 // do this if there exists at least one bid.
	 rs1.next();
	 maxbid = rs1.getDouble("max(bid_amt)");
	 newminbid = maxbid + minincrement;
 }else{
	 // do this if there are no bids.
	 //out.println("Checking start price");
	 Statement st2 = con.createStatement();
	 ResultSet rs2;
	 rs2 = st2.executeQuery("select start_price from auction where auction_num =" + "'" + auctionnum + "'");
	 rs2.next();
	 maxbid = rs2.getDouble("start_price");
	 // MARK CHANGED THIS FROM MAXBID + MININCREMENT TO JUST MAXBID
	 newminbid = maxbid;
	 st2.close();
	 rs2.close();
	 alert = false;
	 // check if user entered an auto bid
	 //out.println("autobid: ");
	 //out.println(autobid);
 }
 if((inputbidamt < newminbid) && (validbidamt)){
	 out.println("Bid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
 }else{
 if((autobid < newminbid) && (validautobid)){
	 out.println("Autobid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
 }else{
 if((autobid < inputbidamt) && (validautobid)){
	 out.println("Autobid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
 }else{
 // JEREMY THIS ENTIRE IF STATEMENT IS ACCOUNTING FOR A USER ONLY INPUTTING AN AUTOBID AND NOT INPUTTING
 // A REGULAR BID
 if((validautobid) && (!validbidamt)){
	 Statement b1 = con.createStatement();
	 ResultSet c1;
	 Statement b2 = con.createStatement();
	 ResultSet c2;
	 Statement b3 = con.createStatement();
	 ResultSet c3;
	 double maxautobid;
	 if(autobid < newminbid){
		 out.println("Autobid is not high enough. Please enter a valid autobid... <a href='bid.jsp'>try again</a>");
	 }else{
	 	c1 = b1.executeQuery("select count(auto_bid) as temp1 from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 	c2 = b2.executeQuery("select max(auto_bid) from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 	
	 	// check to see if inputted autobid is less than any current autobids.
	 	c1.next();
	 	int numautobids = c1.getInt("temp1");
	 	// MARK CHANGED FROM == 1 TO > 0
	 	if(numautobids > 0){
	 		// this autobid is higher than the current maximum bid.
	 		c2.next();
	 		maxautobid = c2.getInt("max(auto_bid)");
	 		c3 = b3.executeQuery("select * from bid where auto_bid =" + "'" + maxautobid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 		if(autobid < maxautobid){
	 			// place bid at autobid and then another bid at next increment.
	 			double nextbid;
	 			if((maxautobid - autobid) < minincrement){
	 				nextbid = maxautobid;
	 			}else{
	 				nextbid = autobid + minincrement;
	 			}
	 			// place first bid
	 			PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement.setDouble(1, autobid);
	 			 statement.setDouble(2, 0);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement.setString(4, username);
	 			 statement.setInt(5, auctionnum);
	 			 statement.execute();
	 			 statement.close();
	 			 //out.println("Success!");
	 			 // place next bid
	 			 // JEREMY THE STATEMENT BELOW IS AN AUTOBID OUTBIDDING SOMEONE ELSE'S INPUTTED AUTOBID
	 			PreparedStatement statement1 = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement1.setDouble(1, nextbid);
	 			 statement1.setDouble(2, maxautobid);
	 			 java.util.Date date1 = new java.util.Date();
	 			 long current1 = date1.getTime();
	 			 Timestamp time1 = new Timestamp(current1);
	 			 statement1.setTimestamp(3, time1);
	 			 c3.next();
	 			 String username1 = c3.getString("username");
	 			 statement1.setString(4, username1);
	 			 statement1.setInt(5, auctionnum);
	 			 statement1.execute();
	 			 statement1.close();
	 			 
	 			if(alert == true){	 				 
	 				 	 				 
					 Statement std9 = con.createStatement();
		 			 Statement std10 = con.createStatement();
		 			 ResultSet rsd9;
		 			 double oldbid = autobid;
		 			 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
		 			 rsd9.next();
		 			 String olduser = rsd9.getString("username");
		 			 String username2 = (String)session.getAttribute("user");
		 			 Statement std11 = con.createStatement();
		 			 ResultSet rsd11;
		 			 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
		 			 rsd11.next();
		 			 String category = rsd11.getString("category");
		 			 String subcat = rsd11.getString("subcat");
		 			 
		 			 
		 			 
		 			 
		 			 
		 			 //austin
		 			 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
		 			 //
		 			 
		 			 
		 			 
		 			 
		 			 
		 			 Statement s3 = con.createStatement();
		 			 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
		 			 r3.next();
		 			 double maxbid2 = r3.getDouble("maxBid");
		 			 std9.close();
		 			 rsd9.close();
		 			 std10.close();
		 			 rsd11.close();
		 			 s3.close();
		 			 r3.close();
		 			 int valid = 1;
		 			 //out.println("AAAAAAAAAAAAAAAAAA");
		 			 Statement std12 = con.createStatement();
		 			 ResultSet rsd12;
		 			 rsd12 = std12.executeQuery("select max(alert_id) from alert");
		 			 int alert_id = 0;
		 			 if(rsd12.first()){
		 			 	alert_id = rsd12.getInt("max(alert_id)");
		 			 	alert_id++;
		 			 }else{
		 			 	alert_id = 1;
		 			 }
		 			 
		 		
		 			
		 				//out.println("TESTING ALERT");
		 			 //if((olduser.equals(username2))){
		 				 //out.println("OLDUSER EQUALING USERNAME2");
		 			 //}else{ 
		 			 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
		 			 statementc36.setString(1, category);
		 			 statementc36.setString(2, subcat);
		 			 statementc36.setString(3, "your autobid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
		 			 statementc36.setInt(4, alert_id);
		 			 statementc36.setString(5, olduser);
		 			 statementc36.setInt(6, valid);
		 			 statementc36.execute();
		 			 out.println("ALERT GOING THROUGH");
		 			 statementc36.close();
		 			 //}
					}
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
				 c3.close();
	 		}else if(autobid >= (maxautobid + minincrement)){
	 			// place bid at maxautobid + minincrement
	 			// JEREMY THE STATEMENT BELOW IS SOMEONE INPUTTING AN AUTOBID WHICH IS GREATER THAN
	 			// THE CURRENT MAX AUTOBID. THE USER WITH THE PREVIOUS MAX AUTO BID IS THE ONE
	 			// BEING OUTBID
	 			double nextbid = maxautobid + minincrement;
	 			PreparedStatement statement2 = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement2.setDouble(1, (nextbid));
	 			 statement2.setDouble(2, autobid);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement2.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement2.setString(4, username);
	 			 statement2.setInt(5, auctionnum);
	 			 statement2.execute();
	 			 statement2.close();
	 			 
	 			if(alert == true){
					 Statement std9 = con.createStatement();
		 			 Statement std10 = con.createStatement();
		 			 ResultSet rsd9;
		 			 double oldbid = maxbid;
		 			 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
		 			 rsd9.next();
		 			 String olduser = rsd9.getString("username");
		 			 String username2 = (String)session.getAttribute("user");
		 			 Statement std11 = con.createStatement();
		 			 ResultSet rsd11;
		 			 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
		 			 rsd11.next();
		 			 
		 			 
		 			 String category = rsd11.getString("category");
		 			 String subcat = rsd11.getString("subcat");
		 			 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
		 			 
		 			 
		 			 Statement s3 = con.createStatement();
		 			 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
		 			 r3.next();
		 			 double maxbid2 = r3.getDouble("maxBid");
		 			 std9.close();
		 			 rsd9.close();
		 			 std10.close();
		 			 rsd11.close();
		 			s3.close();
		 			 r3.close();
		 			 int valid = 1;
		 			 //out.println("AAAAAAAAAAAAAAAAAA");
		 			 Statement std12 = con.createStatement();
		 			 ResultSet rsd12;
		 			 rsd12 = std12.executeQuery("select max(alert_id) from alert");
		 			 int alert_id = 0;
		 			 if(rsd12.first()){
		 			 	alert_id = rsd12.getInt("max(alert_id)");
		 			 	alert_id++;
		 			 }else{
		 			 	alert_id = 1;
		 			 }
		 			 //if((olduser.equals(username2))){
		 			 //}else{ 
		 			 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
		 			 statementc36.setString(1, category);
		 			 statementc36.setString(2, subcat);
		 			 statementc36.setString(3, "your autobid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
		 			 statementc36.setInt(4, alert_id);
		 			 statementc36.setString(5, olduser);
		 			 statementc36.setInt(6, valid);
		 			 statementc36.execute();
		 			 //out.println("ALERT GOING THROUGH");
		 			statementc36.close();
		 			 //}
					 }
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 		}else if(autobid < (maxautobid + minincrement)){
	 			out.println("Autobid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
	 		}
	 	}else if(numautobids == 0){
	 		// write code to put autobid if there are no autobids.
	 		// JEREMY THERE MAY BE AN OUTBID HERE. IT DEPENDS ON IF NEWMINBID IS CREATED FROM THE
	 		// CURRENT MAX BID OR IF IT IS CREATED FROM THE REQUIRED START PRICE WHICH MEANS
	 		// THERE ARE NO CURRENT BIDS.
	 		//double bidamt = newminbid;
	 		PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
		 	statement.setDouble(1, newminbid);
		 	statement.setDouble(2, autobid);
		 	java.util.Date date = new java.util.Date();
	 		long current = date.getTime();
		 	Timestamp time = new Timestamp(current);
		 	statement.setTimestamp(3, time);
		 	String username = (String)session.getAttribute("user");
		 	statement.setString(4, username);
		 	statement.setInt(5, auctionnum);
		 	statement.execute();
		 	statement.close();
		 	
		 	if(alert == true){
				 Statement std9 = con.createStatement();
				 Statement std10 = con.createStatement();
				 ResultSet rsd9;
				 double oldbid = maxbid;
				 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
				 rsd9.next();
				 String olduser = rsd9.getString("username");
				 String username2 = (String)session.getAttribute("user");
				 Statement std11 = con.createStatement();
				 ResultSet rsd11;
				 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
				 rsd11.next();
				 String category = rsd11.getString("category");
				 String subcat = rsd11.getString("subcat");
				 Statement sm = con.createStatement();
 				 Statement sm2= con.createStatement();
 				 ResultSet catname, subname;
 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
 				 catname.next();
 				 subname.next();
	 			 category = catname.getString("cat_name");
	 			 subcat = subname.getString("subcat_name");
	 			 sm.close();
	 			 sm2.close();
	 			 catname.close();
	 			 subname.close();
				 Statement s3 = con.createStatement();
				 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
				 r3.next();
				 double maxbid2 = r3.getDouble("maxBid");
				 std9.close();
				 rsd9.close();
				 std10.close();
				 rsd11.close();
				 s3.close();
	 			 r3.close();
				 int valid = 1;
				 //out.println("AAAAAAAAAAAAAAAAAA");
				 Statement std12 = con.createStatement();
				 ResultSet rsd12;
				 rsd12 = std12.executeQuery("select max(alert_id) from alert");
				 int alert_id = 0;
				 if(rsd12.first()){
				 	alert_id = rsd12.getInt("max(alert_id)");
				 	alert_id++;
				 }else{
				 	alert_id = 1;
				 }
				 //if((olduser.equals(username2))){
				 //}else{ 
				 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
				 statementc36.setString(1, category);
				 statementc36.setString(2, subcat);
				 statementc36.setString(3, "your bid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
				 statementc36.setInt(4, alert_id);
				 statementc36.setString(5, olduser);
				 statementc36.setInt(6, valid);
				 statementc36.execute();
				 //out.println("ALERT GOING THROUGH");
				 statementc36.close();
				 //}
				}
		 	
		 	out.println("Success!");
		 	out.println();
			out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 	}
	 	c1.close();
	 	c2.close();
	 }
	 b1.close();
	 b2.close();
	 b3.close();
 }else if((validautobid) && (validbidamt)){
	 Statement b1 = con.createStatement();
	 ResultSet c1;
	 Statement b2 = con.createStatement();
	 ResultSet c2;
	 Statement b3 = con.createStatement();
	 ResultSet c3;
	 double maxautobid;
	 if(inputbidamt < newminbid){
		 out.println("inputted bid amount is invalid.... <a href='bid.jsp'>try again</a>");
	 }else{
	 if(inputbidamt > autobid){
		 out.println("autobid is less than inputted bid amount.... <a href='bid.jsp'>try again</a>");
	 }else{
	 if(autobid < newminbid){
		 out.println("Autobid is not high enough. Please enter a valid autobid... <a href='bid.jsp'>try again</a>");
	 }else{
	 	c1 = b1.executeQuery("select count(auto_bid) as temp1 from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 	c2 = b2.executeQuery("select max(auto_bid) from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 	
	 	// check to see if inputted autobid is less than any current autobids.
	 	c1.next();
	 	int numautobids = c1.getInt("temp1");
	 	// MARK CHANGED THIS FROM == 1 TO > 0
	 	if(numautobids > 0){
	 		// this autobid is higher than the current maximum bid.
	 		c2.next();
	 		maxautobid = c2.getInt("max(auto_bid)");
	 		c3 = b3.executeQuery("select * from bid where auto_bid =" + "'" + maxautobid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 		if(autobid < maxautobid){
	 			// place bid at autobid and then at next increment.
	 			double nextbid;
	 			if((maxautobid - autobid) < minincrement){
	 				nextbid = maxautobid;
	 			}else{
	 				nextbid = autobid + minincrement;
	 			}
	 			// place first bid
	 			// JEREMY THIS GUY IS BEING OUTBID BY THE STATEMENT BELOW THIS ONE
	 			PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement.setDouble(1, autobid);
	 			 // MARK CHANGED AUTOBID TO 0
	 			 statement.setDouble(2, 0);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement.setString(4, username);
	 			 statement.setInt(5, auctionnum);
	 			 statement.execute();
	 			 statement.close();
	 			 //out.println("Success!");
	 			 // place next bid
	 			 // JEREMY THE STATEMENT BELOW IS SOMEONE'S AUTOBID OUTBIDDING A USER'S INPUTTED AUTOBID
	 			PreparedStatement statement1 = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement1.setDouble(1, nextbid);
	 			 statement1.setDouble(2, maxautobid);
	 			 java.util.Date date1 = new java.util.Date();
	 			 long current1 = date1.getTime();
	 			 Timestamp time1 = new Timestamp(current1);
	 			 statement1.setTimestamp(3, time1);
	 			 c3.next();
	 			 String username1 = c3.getString("username");
	 			 statement1.setString(4, username1);
	 			 statement1.setInt(5, auctionnum);
	 			 statement1.execute();
	 			 statement1.close();
	 			 
	 			if(alert == true){
					 Statement std9 = con.createStatement();
					 Statement std10 = con.createStatement();
					 ResultSet rsd9;
					 double oldbid = autobid;
					 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
					 rsd9.next();
					 String olduser = rsd9.getString("username");
					 String username2 = (String)session.getAttribute("user");
					 Statement std11 = con.createStatement();
					 ResultSet rsd11;
					 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
					 rsd11.next();
					 String category = rsd11.getString("category");
					 String subcat = rsd11.getString("subcat");
					 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
					 Statement s3 = con.createStatement();
					 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
					 r3.next();
					 double maxbid2 = r3.getDouble("maxBid");
					 std9.close();
					 rsd9.close();
					 std10.close();
					 rsd11.close();
					 s3.close();
		 			 r3.close();
					 int valid = 1;
					 //out.println("AAAAAAAAAAAAAAAAAA");
					 Statement std12 = con.createStatement();
					 ResultSet rsd12;
					 rsd12 = std12.executeQuery("select max(alert_id) from alert");
					 int alert_id = 0;
					 if(rsd12.first()){
					 	alert_id = rsd12.getInt("max(alert_id)");
					 	alert_id++;
					 }else{
					 	alert_id = 1;
					 }
					 //if((olduser.equals(username2))){
					 //}else{ 
					 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
					 statementc36.setString(1, category);
					 statementc36.setString(2, subcat);
					 statementc36.setString(3, "your autobid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
					 statementc36.setInt(4, alert_id);
					 statementc36.setString(5, olduser);
					 statementc36.setInt(6, valid);
					 statementc36.execute();
					 //out.println("ALERT GOING THROUGH");
					 statementc36.close();
					 //}
						}
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
				 c3.close();
	 		}else if(autobid >= (maxautobid + minincrement)){
	 			// place bid at maxautobid + minincrement
	 			// JEREMY THE STATEMENT BELOW IS SOMEONE OUTBIDDING THE CURRENT MAX AUTOBID.
	 			double nextbid = maxautobid + minincrement;
	 			PreparedStatement statement2 = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement2.setDouble(1, (nextbid));
	 			 statement2.setDouble(2, autobid);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement2.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement2.setString(4, username);
	 			 statement2.setInt(5, auctionnum);
	 			 statement2.execute();
	 			 statement2.close();
	 			 
	 			if(alert == true){
					 Statement std9 = con.createStatement();
					 Statement std10 = con.createStatement();
					 ResultSet rsd9;
					 double oldbid = maxbid;
					 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
					 rsd9.next();
					 String olduser = rsd9.getString("username");
					 String username2 = (String)session.getAttribute("user");
					 Statement std11 = con.createStatement();
					 ResultSet rsd11;
					 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
					 rsd11.next();
					 String category = rsd11.getString("category");
					 String subcat = rsd11.getString("subcat");
					 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
					 Statement s3 = con.createStatement();
					 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
					 r3.next();
					 double maxbid2 = r3.getDouble("maxBid");
					 std9.close();
					 rsd9.close();
					 std10.close();
					 rsd11.close();
					 s3.close();
		 			 r3.close();
					 int valid = 1;
					 //out.println("AAAAAAAAAAAAAAAAAA");
					 Statement std12 = con.createStatement();
					 ResultSet rsd12;
					 rsd12 = std12.executeQuery("select max(alert_id) from alert");
					 int alert_id = 0;
					 if(rsd12.first()){
					 	alert_id = rsd12.getInt("max(alert_id)");
					 	alert_id++;
					 }else{
					 	alert_id = 1;
					 }
					 //if((olduser.equals(username2))){
					 //}else{ 
					 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
					 statementc36.setString(1, category);
					 statementc36.setString(2, subcat);
					 statementc36.setString(3, "your autobid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
					 statementc36.setInt(4, alert_id);
					 statementc36.setString(5, olduser);
					 statementc36.setInt(6, valid);
					 statementc36.execute();
					 //out.println("ALERT GOING THROUGH");
					 statementc36.close();
					 //}
					}
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 		}else if(autobid < (maxautobid + minincrement)){
	 			out.println("Bid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
	 		}
	 	}else if(numautobids == 0){
	 		// write code to put autobid if there are no autobids.
	 		//double bidamt = newminbid;
	 		// JEREMY THIS ONE IS THE SAME AS BEFORE, SOMEONE MAY OR MAY BE OUTBID HERE. DEPENDS ON HOW
	 		// NEWMINBID IS RETRIEVED.
	 		PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
		 	statement.setDouble(1, inputbidamt);
		 	statement.setDouble(2, autobid);
		 	java.util.Date date = new java.util.Date();
	 		long current = date.getTime();
		 	Timestamp time = new Timestamp(current);
		 	statement.setTimestamp(3, time);
		 	String username = (String)session.getAttribute("user");
		 	statement.setString(4, username);
		 	statement.setInt(5, auctionnum);
		 	statement.execute();
		 	statement.close();
		 	
		 	if(alert == true){
				 Statement std9 = con.createStatement();
				 Statement std10 = con.createStatement();
				 ResultSet rsd9;
				 double oldbid = maxbid;
				 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
				 rsd9.next();
				 String olduser = rsd9.getString("username");
				 String username2 = (String)session.getAttribute("user");
				 Statement std11 = con.createStatement();
				 ResultSet rsd11;
				 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
				 rsd11.next();
				 String category = rsd11.getString("category");
				 String subcat = rsd11.getString("subcat");
				 Statement sm = con.createStatement();
 				 Statement sm2= con.createStatement();
 				 ResultSet catname, subname;
 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
 				 catname.next();
 				 subname.next();
	 			 category = catname.getString("cat_name");
	 			 subcat = subname.getString("subcat_name");
	 			 sm.close();
	 			 sm2.close();
	 			 catname.close();
	 			 subname.close();
				 Statement s3 = con.createStatement();
				 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
				 r3.next();
				 double maxbid2 = r3.getDouble("maxBid");
				 std9.close();
				 rsd9.close();
				 std10.close();
				 rsd11.close();
				 s3.close();
	 			 r3.close();
				 int valid = 1;
				 //out.println("AAAAAAAAAAAAAAAAAA");
				 Statement std12 = con.createStatement();
				 ResultSet rsd12;
				 rsd12 = std12.executeQuery("select max(alert_id) from alert");
				 int alert_id = 0;
				 if(rsd12.first()){
				 	alert_id = rsd12.getInt("max(alert_id)");
				 	alert_id++;
				 }else{
				 	alert_id = 1;
				 }
				 //if((olduser.equals(username2))){
				 //}else{ 
				 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
				 statementc36.setString(1, category);
				 statementc36.setString(2, subcat);
				 statementc36.setString(3, "your bid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
				 statementc36.setInt(4, alert_id);
				 statementc36.setString(5, olduser);
				 statementc36.setInt(6, valid);
				 statementc36.execute();
				 //out.println("ALERT GOING THROUGH");
				 statementc36.close();
				 //}
					}
		 	
		 	out.println("Success!");
		 	out.println();
			out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 	}
	 	c1.close();
	 	c2.close();
	 }
	 }
	 }
	 b1.close();
	 b2.close();
	 b3.close();
 }else if((inputbidamt >= newminbid) && (validbidamt) && (!validautobid)){
	 Statement b1 = con.createStatement();
	 ResultSet c1;
	 Statement b2 = con.createStatement();
	 ResultSet c2;
	 Statement b3 = con.createStatement();
	 ResultSet c3;
	 double maxautobid;
	 c1 = b1.executeQuery("select count(auto_bid) as temp1 from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 c2 = b2.executeQuery("select max(auto_bid) from bid where auto_bid >" + "'" + maxbid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 
	 c1.next();
	 int numautobids = c1.getInt("temp1");
	 // MARK I CHANGED THIS TO > 0. WAS == 0 PREVIOUSLY
	 if(numautobids > 0){
	 		// this autobid is higher than the current maximum bid.
	 		c2.next();
	 		maxautobid = c2.getInt("max(auto_bid)");
	 		c3 = b3.executeQuery("select * from bid where auto_bid =" + "'" + maxautobid + "'" + "and auction_num =" + "'" + auctionnum + "'");
	 		if(inputbidamt < maxautobid){
	 			double nextbid;
	 			if((maxautobid - inputbidamt) < minincrement){
	 				nextbid = maxautobid;
	 			}else{
	 				nextbid = inputbidamt + minincrement;
	 			}
	 			// place first user's bid
	 			// JEREMY THE GUY BELOW IS THE ONE BEING OUTBID.
	 			PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement.setDouble(1, inputbidamt);
	 			 statement.setDouble(2, 0);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement.setString(4, username);
	 			 statement.setInt(5, auctionnum);
	 			 statement.execute();
	 			 statement.close();
	 			 //out.println("Success!");
	 			 // place higher autobidders bid
	 			 // JEREMY THIS GUY IS THE ONE DOING THE OUTBIDDING.
	 			PreparedStatement statement1 = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement1.setDouble(1, nextbid);
	 			 // MARK CHANGED THIS FROM AUTOBID TO MAXAUTOBID
	 			 statement1.setDouble(2, maxautobid);
	 			 java.util.Date date1 = new java.util.Date();
	 			 long current1 = date1.getTime();
	 			 Timestamp time1 = new Timestamp(current1);
	 			 statement1.setTimestamp(3, time1);
	 			 // get upper bidder's username
	 			 c3.next();
	 			 String username1 = c3.getString("username");
	 			 //username1 = (String)session.getAttribute("user");
	 			 statement1.setString(4, username1);
	 			 statement1.setInt(5, auctionnum);
	 			 statement1.execute();
	 			 statement1.close();
	 			 
	 			if(alert == true){	
					 Statement std9 = con.createStatement();
					 Statement std10 = con.createStatement();
					 ResultSet rsd9;
					 double oldbid = inputbidamt;
					 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
					 rsd9.next();
					 String olduser = rsd9.getString("username");
					 String username2 = (String)session.getAttribute("user");
					 Statement std11 = con.createStatement();
					 ResultSet rsd11;
					 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
					 rsd11.next();
					 String category = rsd11.getString("category");
					 String subcat = rsd11.getString("subcat");
					 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
					 Statement s3 = con.createStatement();
					 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
					 r3.next();
					 double maxbid2 = r3.getDouble("maxBid");
					 std9.close();
					 rsd9.close();
					 std10.close();
					 rsd11.close();
					 s3.close();
		 			 r3.close();
					 int valid = 1;
					 //out.println("AAAAAAAAAAAAAAAAAA");
					 Statement std12 = con.createStatement();
					 ResultSet rsd12;
					 rsd12 = std12.executeQuery("select max(alert_id) from alert");
					 int alert_id = 0;
					 if(rsd12.first()){
					 	alert_id = rsd12.getInt("max(alert_id)");
					 	alert_id++;
					 }else{
					 	alert_id = 1;
					 }
					 //if((olduser.equals(username2))){
					 //}else{ 
					 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
					 statementc36.setString(1, category);
					 statementc36.setString(2, subcat);
					 statementc36.setString(3, "your bid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
					 statementc36.setInt(4, alert_id);
					 statementc36.setString(5, olduser);
					 statementc36.setInt(6, valid);
					 statementc36.execute();
					 //out.println("ALERT GOING THROUGH");
					 statementc36.close();
					 //}
					}
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
				 c3.close();
	 		}else if(inputbidamt >= (maxautobid + minincrement)){
	 			// JEREMY THIS GUY IS THE ONE DOING THE OUTBIDDING. THE GUY WITH THE MAX AUTOBID IS THE
	 			// ONE WHO IS BEING OUTBID.
	 			PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
	 			 statement.setDouble(1, inputbidamt);
	 			 statement.setDouble(2, 0);
	 			 java.util.Date date = new java.util.Date();
	 			 long current = date.getTime();
	 			 Timestamp time = new Timestamp(current);
	 			 statement.setTimestamp(3, time);
	 			 String username = (String)session.getAttribute("user");
	 			 statement.setString(4, username);
	 			 statement.setInt(5, auctionnum);
	 			 statement.execute();
	 			 statement.close();
	 			 
	 			if(alert == true){
					 Statement std9 = con.createStatement();
					 Statement std10 = con.createStatement();
					 ResultSet rsd9;
					 double oldbid = maxbid;
					 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
					 rsd9.next();
					 String olduser = rsd9.getString("username");
					 String username2 = (String)session.getAttribute("user");
					 Statement std11 = con.createStatement();
					 ResultSet rsd11;
					 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
					 rsd11.next();
					 String category = rsd11.getString("category");
					 String subcat = rsd11.getString("subcat");
					 Statement sm = con.createStatement();
	 				 Statement sm2= con.createStatement();
	 				 ResultSet catname, subname;
	 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
	 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
	 				 catname.next();
	 				 subname.next();
		 			 category = catname.getString("cat_name");
		 			 subcat = subname.getString("subcat_name");
		 			 sm.close();
		 			 sm2.close();
		 			 catname.close();
		 			 subname.close();
					 Statement s3 = con.createStatement();
					 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
					 r3.next();
					 double maxbid2 = r3.getDouble("maxBid");
					 std9.close();
					 rsd9.close();
					 std10.close();
					 rsd11.close();
					 s3.close();
		 			 r3.close();
					 int valid = 1;
					 //out.println("AAAAAAAAAAAAAAAAAA");
					 Statement std12 = con.createStatement();
					 ResultSet rsd12;
					 rsd12 = std12.executeQuery("select max(alert_id) from alert");
					 int alert_id = 0;
					 if(rsd12.first()){
					 	alert_id = rsd12.getInt("max(alert_id)");
					 	alert_id++;
					 }else{
					 	alert_id = 1;
					 }
					 //if((olduser.equals(username2))){
					 //}else{ 
					 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
					 statementc36.setString(1, category);
					 statementc36.setString(2, subcat);
					 statementc36.setString(3, "your autobid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
					 statementc36.setInt(4, alert_id);
					 statementc36.setString(5, olduser);
					 statementc36.setInt(6, valid);
					 statementc36.execute();
					 //out.println("ALERT GOING THROUGH");
					 statementc36.close();
					 //}
					}
	 			 
	 			 out.println("Success!");
	 			 out.println();
				 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 		}else if(inputbidamt < (maxautobid + minincrement)){
	 			out.println("Bid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
	 		}
	 }else if(numautobids == 0){
		 // JEREMY THIS IS THE SAME BEFORE. I AM NOT SURE IF SOMEONE IS BEING OUTBID OR NOT. DEPENDS
		 // ON NEWMINBID.
		 PreparedStatement statement = con.prepareStatement("insert into bid (bid_amt, auto_bid, date_time, username, auction_num) values (?, ?, ?, ?, ?)");
			 statement.setDouble(1, inputbidamt);
			 statement.setDouble(2, 0);
			 java.util.Date date = new java.util.Date();
			 long current = date.getTime();
			 Timestamp time = new Timestamp(current);
			 statement.setTimestamp(3, time);
			 String username = (String)session.getAttribute("user");
			 statement.setString(4, username);
			 statement.setInt(5, auctionnum);
			 statement.execute();
			 statement.close();
			 
			 if(alert == true){

				 Statement std9 = con.createStatement();
				 Statement std10 = con.createStatement();
				 ResultSet rsd9;
				 double oldbid =  maxbid;
				 rsd9 = std9.executeQuery("select username from bid where auction_num =" + "'" + auctionnum + "' and bid_amt =" + "'" + oldbid + "'");
				 rsd9.next();
				 String olduser = rsd9.getString("username");
				 String username2 = (String)session.getAttribute("user");
				 Statement std11 = con.createStatement();
				 ResultSet rsd11;
				 rsd11 = std11.executeQuery("select * from auction where auction_num =" + "'" + auctionnum + "'");
				 rsd11.next();
				 String category = rsd11.getString("category");
				 String subcat = rsd11.getString("subcat");
				 Statement sm = con.createStatement();
 				 Statement sm2= con.createStatement();
 				 ResultSet catname, subname;
 				 catname = sm.executeQuery("SELECT cat_name FROM category WHERE cat_id=" + "'" + category + "'");
 				 subname = sm2.executeQuery("SELECT subcat_name FROM subcategory WHERE subcat_id=" + "'" + subcat + "'");
 				 catname.next();
 				 subname.next();
	 			 category = catname.getString("cat_name");
	 			 subcat = subname.getString("subcat_name");
	 			 sm.close();
	 			 sm2.close();
	 			 catname.close();
	 			 subname.close();
				 Statement s3 = con.createStatement();
				 ResultSet r3 = s3.executeQuery("SELECT MAX(bid_amt) as maxBid FROM bid WHERE auction_num=" + "'" + auctionnum + "'");
				 r3.next();
				 double maxbid2 = r3.getDouble("maxBid");
				 std9.close();
				 rsd9.close();
				 std10.close();
				 rsd11.close();
				 s3.close();
	 			 r3.close();
				 int valid = 1;
				 //out.println("AAAAAAAAAAAAAAAAAA");
				 Statement std12 = con.createStatement();
				 ResultSet rsd12;
				 rsd12 = std12.executeQuery("select max(alert_id) from alert");
				 int alert_id = 0;
				 if(rsd12.first()){
				 	alert_id = rsd12.getInt("max(alert_id)");
				 	alert_id++;
				 }else{
				 	alert_id = 1;
				 }
				 //if((olduser.equals(username2))){
				 //}else{ 
				 PreparedStatement statementc36 = con.prepareStatement("insert into alert (cat_name, subcat_name, description, alert_id, username, valid) values (?,?, ?, ?, ?, ?)");
				 statementc36.setString(1, category);
				 statementc36.setString(2, subcat);
				 statementc36.setString(3, "your bid has been outbid on auction number: " + "'" + auctionnum + "' by a bid of: $" + "'" + maxbid2 + "'");
				 statementc36.setInt(4, alert_id);
				 statementc36.setString(5, olduser);
				 statementc36.setInt(6, valid);
				 statementc36.execute();
				 //out.println("ALERT GOING THROUGH");
				 statementc36.close();
				 
				 //}
				 
				 
				 
			 }
			 
			 out.println("Success!");
			 out.println();
			 out.println("Click here to go back to the homepage. <a href='homepage.jsp'>homepage</a>");
	 }
	 b1.close();
	 c1.close();
	 b2.close();
	 c2.close();
	 b3.close();
	  
 }else if((inputbidamt < newminbid) && (validbidamt)){
	 out.println("Bid is not high enough. Please enter a valid bid... <a href='bid.jsp'>try again</a>");
 }
 
 st.close();
 st1.close();
 rs1.close();
 z.close();
 y.close();	
 }
 }
 }
 }
 }
 }
 con.close();
 st.close();
 rs.close();
 temp.close();
 hold.close();
 }
 %>
</body>
</html>
 