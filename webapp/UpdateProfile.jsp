<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ page import = "java.io.*,java.util.*,java.sql.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Profile</title>
</head>
<body>
<center>
<h1>Update Profile</h1>
<form action ="#" method="POST">
<input type="text" placeholder="Name" name="name" /><br>
<input type="number" placeholder="Age" name="age" /><br>
<input type="text" placeholder="Phone number" name="phone" /><br>
<input type="text" placeholder="Mail" name="mail" /><br><br>
<input type="submit" />
</form>
<%
if((request.getMethod()).equals("POST")){
try {
    int age;
    String name, phone, mail;
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
    PreparedStatement stmt = con.prepareStatement("UPDATE Customers SET Name=?,Age=?,Phone=?,Mail=? WHERE Customer_ID=?");

    name = request.getParameter("name");
	int customer_id = (Integer)session.getAttribute("customer_id");
    age = Integer.parseInt(request.getParameter("age"));
    phone = request.getParameter("phone");
    mail = request.getParameter("mail");
    stmt.setInt(5, customer_id);
    stmt.setString(1, name);
    stmt.setInt(2, age);
    stmt.setString(3, phone);
    stmt.setString(4, mail);
    stmt.executeUpdate();
    System.out.println("profile Updated");
    response.sendRedirect("./viewProfile.jsp");
} catch (Exception e) {
    System.out.println(e);
}
}
%>
<%
	if(((Integer)session.getAttribute("isAdmin"))==1){ %>
		<a href="./admin/adminMenu.html">Menu</a>
<% 		
	}
	else{
%> <a href="./customer/customerMenu.html">Menu</a>
<% 
	}
%>
</center>
</body>
</html>