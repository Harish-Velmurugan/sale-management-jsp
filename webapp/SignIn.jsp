<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SignIn</title>
</head>
<body>
<% 
try{
	
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
    PreparedStatement stmt = con.prepareStatement("SELECT * FROM Customers where Mail=?");
    
    String Username = request.getParameter("username");
    String Password = request.getParameter("password");
    stmt.setString(1,Username);
    ResultSet rs = stmt.executeQuery();
    rs.next();
    if(rs.getString("Password").equals(Password)){
    	session.setAttribute("customer_id", rs.getInt("Customer_ID"));
    	out.println("authentication sucessfull");
    	if(rs.getInt("isAdmin") == 1){
    		out.print("Admin Login");
    		session.setAttribute("isAdmin",1);
    		response.sendRedirect("./adminMenu.html");
    	}
    	else{
    		out.print("customer login");
    		session.setAttribute("isAdmin",0);
    		response.sendRedirect("./customerMenu.html");
    	}
    	  
	}
   	else{
   		out.println("wrong password");
   	}
    
    
    con.close(); 
}catch(Exception e){ System.out.println(e);}


%> 


</body>
</html>