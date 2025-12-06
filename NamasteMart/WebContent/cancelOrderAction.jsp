<%@page language="java"contentType="text/html;charset=UTF-8"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.namastemart.service.impl.*"%>
<%@page import="com.namastemart.service.*"%>
<%@page import="com.namastemart.beans.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.servlet.*"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.io.*"%>

<%
//Retrieve orderId from request parameter

String orderId=request.getParameter("orderId");

String accountNumber=request.getParameter("accountNumber");
String bank=request.getParameter("bank");
String ifscCode=request.getParameter("ifscCode");

OrderService orderService=new OrderServiceImpl();
OrderDetails orderDetails=OrderService.getOrderDetailsById(orderId);

String message;
if(OrderDetails!=null){
	try{
		double refundAmount=Double.parseDouble(OrderDetails.getAmount());
		boolean isCancelled=orderService.cancelOrder(orderId,accountNumber,bank,ifscCode);
		if(isCancelled){
			String userEmail=(String)session.getAttribute("username");
			//missing line
			message="your refund request has been recieved it will be pressesing soon";
		}else{
			message="failed to cancel the order please try again";
		}
	}catch(NumberFormatException e){
		out.println(e);
	}
	
}else{
	message="order not found";
}
request.setAttribute("message",message);
request.getRequestDispatcher("orderCancelConfirmation.jsp").forward(request,response);
%>