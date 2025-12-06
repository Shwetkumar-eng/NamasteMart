<%@page import="com.google.gson.Gson"%>
<%@page import="com.namastemart.service.impl.*"%>
<%@page import="com.namastemart.service.*"%>
<%@page import="com.namastemart.beans.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Order Details</title>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width,initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
.table>tbody>tr>td,.table>tbody>tr>th,.table>tfoot>tr>td,.table>tfoot>tr>th,.table>thead>tr>td,
.table>thead>tr>th{
	border:1px solid black !important;
}
.cancel-button{
	margin:20px 0;
}
.disabled-btn{
	cursor:not-allowed;
	opacity:0.6;
}
</style>
</head>
<body>
<%
String userName=(String)session.getAttribute("username");
String password=(String)session.getAttribute("password");
if(userName==null||password==null){
	response.sendRedirect("login.jsp?message=session Expired,Login Again");
	
	
}
OrderService dao=new OrderServiceImpl();
List<OrderDetails> orders=dao.getAllOrderDetails(userName);
%>
jsp:include page="header.jsp"/>

<div class="text-center"style="color:black:font-size:24px;font-weight:bold;">Order Details

</div>

<div class="container">
<div class="table-responsive">
<table class="table table-hover">
<thead style="background-color:#341ab;color:white;font-size:16px;font-weight:bold;">
<tr>
<th>Picture</th>
<th>Product Name</th>
<th>Order Id</th>
<th>Quantity</th>
<th>Price</th>
<th>Time</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody  style="background-color:#f1cdf6;font-size:15px;font-weight:bold;" >


<%
for(Order order:orders){
	String orderStatus="";
	switch(order.getShipped()){
		case 0:
		orderStatus="ORDER_PLACED";
		break;
		
		case 1:
		orderStatus="SHIPPED";
		break;
		
		case 0:
		orderStatus="ORDER_CANCELLED";
		break;
	}


%>

<tr>
<td><img src="./ShowImage?pid=<%=product.getProdId()%>"
style="width:50px;height:50px;"></td>
<td><%=product.getProdName()%></td>
<td><%=product.getOrderId()%></td>
<td><%=product.getQty()%></td>
<td><%=product.getAmount()%></td>
<td><%=product.getTime()%></td>
<td class="text-sucess"><%=orderStatus%></td>
<td>
<%
if(order.getShipped()==0 ||order.getShipped()==1){
%>
<a href="orderCancel.jsp?orderId=<%=order.getOrderId()%>" class="btn btn-danger btn-sm">Cancel
</a>
<%
}else {
%>
<button class="btn btn-danger btn-sm disabled-btn" disabled>Cancelled</button>
<%}%>
</td>
</tr>
<%
	}
}
%>
</tbody>
</table>
</div>
</div>
<%@:include page="footer.html"%>
</body>
</html>