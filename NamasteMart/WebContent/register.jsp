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
<form action="./RegisterSrv"method="post"
class="col-md-6 col-md-offset-3"
style="border:2px solid black;border-redius:10px; background-color:#b341ab;padding:10px;">
<div style="font-weight:bold;" class="text-center">
<h2 style="color:black;">Registration Form</h2>
<%if(message!=null){%>
<p style="color:rgb(25,252,25);">
<%=message%>
</p>
<%}%>

</div>
<div></div>
<div class="row">
<div class="col-md-6 form-group">
<label for="first_name">Name</label><input type="text"
placeholder="enter name" name="username" class="form-control"
id="first_name" required>
</div>

<div class="col-md-6 form-group">
<label for="last_name">Email</label><input type="email"
placeholder="enter name" name="email" class="form-control"
id="last_name" required>
</div>

</div>

<div class="form-group">
<label for="address">Address</label>
<textarea name="address" class="form-control" id="address"required</textarea>

</div>

<div class="row text-center">
<div class="col-md-6 form-group">
<label for="mobile">Mobile</label><input type="number"
placeholder="enter mobile" name="mobile" class="form-control"
id="mobile" required>
</div>

<div class="col-md-6 form-group">
<label for="pincode">Pin Code</label><input type="number"
placeholder="enter pincode" name="pincode" class="form-control"
id="pincode" required>
</div>

</div>

<div class="row text-center">
<div class="col-md-6 form-group">
<label for="password">Password</label><input type="password"
placeholder="enter password" name="password" class="form-control"
id="password" required>
</div>

<div class="col-md-6 form-group">
<label for="confirmPassword">Confirm Password</label><input type="password"
placeholder="enter confirmPassword" name="confirmPassword" class="form-control"
id="confirmPassword" required>
</div>
</div>

<div class="form-group">
<label for="image">Profile Image</label>
<input type="file" class="form-control" name="image" id="image" required>

</div>

<div class="row text-center">
<div class="col-md-6" style="margin-bottom:2px;">
<button type="reset" class="btn btn-danger">Reset</button>
</div>

<div class="col-md-6">
<button type="submit" class="btn btn-success">Register</button>
</div>
</div>

</form>
</div>
</div>
<%@include page="footer.html"%>

</body>
</html>