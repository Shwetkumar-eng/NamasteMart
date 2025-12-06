<%@page language="java"contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
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
<title>LayOut Header</title>
<meta charset="utf-8">
<meta name="viewport"content="width=device-width,initial-scale=1">
<link rel="stylesheet"href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
<link rel="stylesheet"href="css/changes.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>

<style>
.btn-danger{
	
	margin-left:520px;
	margin-top:10px;
	font-size:large;
	font-weight:bolder;
	
}

.alert-success{
	margin-top:20px;
	font-size:x-large;
	font-weight:bolder;
}
</style>
</head>
<body style="margin-top:60px">
<jsp:include page="profileHeader.jsp"/>
<div class="container">
<h2 class="text-center">Cancel Your Order</h2>
<form action="orderCancel.jsp" method="post">
<div class="form-group">
<label for="orderId">OrderId;</label>
<input type="text" class="form-control" id="orderId" name="orderId"requered value="<%=
request.getParameter("orderId")%>">
</div>
<div class="form-group">
<label for="accountNumber">Account Number;</label>
<input type="text" class="form-control" id="accountNumber" name="accountNumber"requered>
</div>

<div class="form-group">
<label for="bank">Bank Name;</label>
<input type="text" class="form-control" id="bank" name="bank"required>
</div>

<div class="form-group">
<label for="ifscCode">IFSC Code;</label>
<input type="text" class="form-control" id="ifscCode" name="ifscCode"required>
</div>
<button type="submit" class="btn btn-danger">Submit</button>
</form>
<%
String message="";
String orderId=request.getParameter("orderId");
String accountNumber=request.getParameter("accountNumber");
String bank=request.getParameter("bank");
String ifscCode=request.getParameter("ifscCode");

String userEmail=(String)session.getAttribute("username");
String userName=(String)session.getAttribute("userName");

if(userEmail==null){
	response.sendRedirect("login.jsp?message=session Expired,Login Again");
}else{
	if(orderId !=null && !orderId.isEmpty() && accountNumber !=null && !accountNumber.isEmpty()
		&& bank !=null && !bank.isEmpty()&&
	ifscCode !=null && !ifscCode.isEmpty()){
		OrderService orderService=new OrderServiceImpl();
		try{
			OrderDetails orderDetails=orderService.getOrderDetailsById(orderId);
			if(orderDetails != null){
				boolean isCancelled=orderService.cancelOrder(orderId,accountNumber,bank,ifscCode,userEmail
				,userName);
				if(isCancelled){
					message="Request for cancellation for OrderId'"+orderId+"'is successfull";
					
				}else{
					message="Failed to cancel the order.please try again";
				}
			}else{
				message="order not found";
			}
		}catch(Exception e){
			e.printStackTrace();
			message="something went wrong error";
		}
		else{
			message="";
		}
	}
}

%>
<div class="alert alert-success">
<%=message%>
</div>
</div>
<%@:include page="footer.html"%>
</body>
</html>