<%@page language="java"contentType="text/html;charset=UTF-8" pageEncoding="ISO-8859-1"%>
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

</head>
<body>
<jsp:include page="header.jsp"/>
<%
String message=request.getParameter("message");
%>
<div class="container">
<div class="row"
style="margin-top:5px;margin-left:2px;margin-right:2px;">
<form action="./LoginSrv"method="post"
class="col-md-4 col-md-offset-4 col-sm-8 col-sm-offset-2"
style="border:2px solid black;border-redius:10px; background-color:#b341ab;padding:10px;">
<div style="font-weight:bold;" class="text-center">
<h2 style="color:black;">Login Form</h2>
<%if(message!=null){%>
<p style="color:rgb(25,252,25);">
<%=message%>
</p>
<%}%>

</div>
<div></div>
<div class="row">
<div class="col-md-12 form-group">
<label for="last_name">Username</label><input type="email"
placeholder="enter Username" name="username" class="form-control"
id="last_name" required>
</div>
</div>

<div class="row">
<div class="col-md-12 form-group">
<label for="last_name">Password</label><input type="password"
placeholder="enter password" name="password" class="form-control"
id="last_name" required>
</div>
</div>

<div class="row">
<div class="col-md-12 form-group">
<label for="userrole">Login As</label><select name="usertype"
id="userrole" class="form-control" required>
<option value="customer" selected="Customer"</option>
<option value="admin" selected="ADMIN"</option>
</select>
</div>
</div>

<div class="row">
<div class="col-md-12 text-center">
<button type="submit" class="btn btn-success">Login</button>
</div>
</div>

</form>
</div>
</div>
<%@:include page="footer.html"%>

</body>
</html>