<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.*" %>
<%@page import="java.io.*" %>
<%
	String id = request.getParameter("userid");
	String driver = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:derby://localhost:1527/";
	String database = "fund_transfer";
	String userid = "root";
	String pass = "root";
	try {
		Class.forName(driver);
	} catch (ClassNotFoundException e) {
	e.printStackTrace();
	}
	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;
	int amount=1000;
	int toAccount=0;
	int availableBal=0;
        int myaccount = Integer.parseInt(request.getParameter("from_account"));
	connection = DriverManager.getConnection(connectionUrl+database, userid, pass);
	statement=connection.createStatement();
        System.out.println(sqls);
	if (request.getParameter("submit") != null) {	
	   	   toAccount = Integer.parseInt(request.getParameter("to_account"));
                   
	   	   PreparedStatement pstatement = null;
	       int updateQuery = 0;
	       String queryString = "insert into \"account_transactions\"(\"amount\",\"from_account\",\"to_account\") values("+amount+","+myaccount+","+toAccount+")";
               System.out.println(queryString);
               pstatement = connection.prepareStatement(queryString);
	       updateQuery = pstatement.executeUpdate();
	   if (updateQuery > 0)
	   { 
	     String  sql = "select * from \"account_details\" where \"account_no\"= "+myaccount+"";
         resultSet = statement.executeQuery(sql);
         while(resultSet.next()){
 	     availableBal = Integer.parseInt(resultSet.getString("balance")) - amount ; 
 	     String queryStringDec = "UPDATE  \"account_details\" set \"balance\"="+availableBal+" where \"account_no\"="+myaccount+"";
		 pstatement = connection.prepareStatement(queryStringDec);
		 updateQuery = pstatement.executeUpdate();
	     }
         out.println("<h1>Fund Transferred Successfully!");
         out.println("<h1>Available balance :" +availableBal);
     %>
      
     <%
	   }
	   else 
	   {
		  out.println("<h1>Error, Not Sent!");
	   }
	  
   }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Transactions</title>
</head>
<body>
	<h1>The last five Transactions : </h1>
	<table border="1">
	<tr>
	  <td>Transaction ID</td>
      <td>Date of Transaction</td>
      <td>Amount</td>
      <td>Account Number</td>
    </tr>
<%
	try{
	connection = DriverManager.getConnection(connectionUrl+database, userid, pass);
	statement=connection.createStatement();
	String sql ="select * from \"account_transactions\" where \"from_account\" = "+myaccount+" fetch first 5 rows only ";
	resultSet = statement.executeQuery(sql);
        int count=0;
	while(resultSet.next()){
%>
	<tr>
	  <td><%=++count %></td>
      <td><%=resultSet.getString("transaction_date") %></td>
      <td><%=resultSet.getString("amount") %></td>
      <td><%=resultSet.getString("to_account") %></td>
    </tr>
<%
    }
    connection.close();
    } catch (Exception e) {
      e.printStackTrace();
    }
%>
</table>
</body>
</html>
