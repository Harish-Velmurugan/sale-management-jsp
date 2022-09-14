<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% 
try{
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/MINI?characterEncoding=utf8","root","Harishwin@123");
//here sonoo is database name, root is username and password
    PreparedStatement stmt=con.prepareStatement("select * from Customers where Mail=?");
	stmt.setString(1,request.getParameter("uname"));
    ResultSet rs=stmt.executeQuery();
    while(rs.next())
        out.println(rs.getString(2)+"  "+rs.getString(4)+"  "+rs.getString(5)+ "\n");
    con.close();
    String name=request.getParameter("uname");  
    out.print("welcome "+name); 
}catch(Exception e){ System.out.println(e);}


%>  
</body>
</html> 		 	