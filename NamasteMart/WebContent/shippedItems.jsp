<%@page language="java"contentType="text/html;charset=ISO-8859-1"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.namastemart.service.impl.*"%>
<%@page import="com.namastemart.service.*"%>
<%@page import="com.namastemart.beans.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.ServletOutputStream"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>

<head>
<title>Admin Home</title>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width,initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
//
//
<style>
body{
	margin:0;
	font-family:Arial,sans-serif;
}

.content{
	margin-left:250px;
	padding:20px;
	transition:margin-left 0.3s;
}

.sidebar.collapsed~.content{
	margin-left:100px;
}

.table-container{
	background-color:#f1cdf6;
	padding-bottom:20px;
	
}

.footer{
	position:absolute;
	left:250px;
	bottom:0;
	width:calc(100%-250px);
	background-color:#333;
	color:white;
	text-align:center;
	padding:10px;
	margin-top:20px;
	transition: left 0.3s,width 0.3s;
}

.sidebar.collapsed~.footer{
	left:60px;
	width:calc(100%-60px);
}
.table>tbody>tr>td,.table>tbody>tr>th,.table>tfoot>tr>td,.table>tfoot>tr>th,.table>thead>tr>td,
.table>thead>tr>th{
	border:1px solid black !important;
}
.status-cancelled{
color:red;
font-weight:bold;
}
.status-shipped,.status-placed{
color:green
font-weight:bold;
}
</style>
</head>
<body>
<%
//checking the user crediantials
String userType=(String)session.getAttribute("usertype");
String userName=(String)session.getAttribute("username");
String password=(String)session.getAttribute("password");

if(userType==null||userType.equals("admin")){
	
	response.sendRedirect("login.jsp?message=Access denied, Login as admin");
	
}

else if(userName==null|| password==null){
	
response.sendRedirect("login.jsp?message=Seesion expired,Login Again");	
	
} 
%>
<%@include file="adminheader.jsp"%>

<div class="content">
<div class="table-container">
<div class="text-center"style="color:black; font-size:24px; font-weight:bold;">
Orders
</div>
<div class="container-fluid">
<div class="table-responsive">
<table class="table table-hover table-sm">
<thead style="background-color:#b341ab;color:white; font-size:18px;">
<tr>
<th>TransactionId</th>
<th>ProductId</th>
<th>UserName</th>
<th>Address</th>
<th>Quantity</th>
<th>Amount</th>
<th>Status</th>
</tr>
</thead> 
<tbody style="background-color:#f1cdf6;">
<%
OrderServiceImpl orderdao=new OrderServiceImpl();
List<OrderBean> orders=orderdao.getAllOrders();
int count=0;
for(OrderBean order:orders){
	String transId=order.getTransactionId();
	String prodId=order.getProductId();
	int quantity=order.getQuantity();
	int shipped=order.getShipped();
	String userId=new TransServiceImpl().getUserId(userId);
	String userAddr=new UserServiceImpl().getUserAddr(userId);
	
	String status;
	String statusClass;
	if(shipped==2){
		Status="CANCELLED";
		statusClass="status-cancelled";
	}else if(shipped==1){
		Status="SHIPPED";
		statusClass="status-shipped";
	}else if(shipped==0){
		Status="ORDER_PLACED";
		statusClass="status-placed";
	}
	else{
		Status="UNKNOWN";
		statusClass="status-placed";
	}
	if(shipped !=0 || shipped==2){
		count++;
%>
<tr>
<td><%=transId%>
</td>
<td><a href="./updateProduct.jsp?prodid=<%=prodId%>"><%=prodId
%></a></td>

<td><%=userId%></td>
<td><%=userAddr%></td>
<td><%=quantity%></td>
<td><%=order.getAmount()%></td>
<td><%=statusClass%></td>
</tr>
<%
	}
}
%>
<%
if(count==0){
%>
<tr style="background-color:#b341ab;color:white;">
<td colspan="7" style="text-align:center;">No Items Available</td>
</tr>
<%}%>


</tbody>
</table>
</div>
</div>
</div>


</div>
<div class="footer">
<p>NamasteMart &copy:2024,All Right Reserved.</p>
</div>

</body>
</html>