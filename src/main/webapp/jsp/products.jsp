<%@page import="com.colin.models.Product"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<title>Product Management Application</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>

	<header>
		<nav class="navbar navbar-expand-md navbar-dark justify-content-between"
			style="background-color: tomato">
			<div class="d-flex">
				<a href="/" class="navbar-brand"> Product CRUD App </a>
				<ul class="navbar-nav">
					<li>
						<a href="/products" class="nav-link">Products</a>
					</li>
				</ul>
			</div>
			<div>
				<a href="/logout" type="button" class="btn btn-light">Logout</a>
			</div>
		</nav>
	</header>
	<br>
	<c:if test="${alertMessage != null}">
		<div class=container>
			<div class="alert alert-warning alert-dismissible fade show" role="alert">
			  <div class="text-center"><strong>Notice: </strong>${alertMessage}</div>
			</div>
		</div>
	</c:if>

	<div class="row">
		<!-- <div class="alert alert-success" *ngIf='message'>{{message}}</div> -->

		<div class="container">
			<h3 class="text-center">Product List</h3> 
			<div class="container col-md-7">
		<div class="card">
			<div class="card-body">
			
				<c:if test = "${!search}">
				<form:form method="POST">
				<fieldset class="form-group">
						<label>Search</label>
						<select class="form-control" name = "searchKey">
							<c:forEach items = "${categories}" var="c">
							<option value = "${c.name}">${c.name}</option>
							</c:forEach>
						</select>
						
					</fieldset>
					
					<div class="d-flex justify-content-around">
						<input type="submit" class="btn btn-success" value="Search"/>
					</div>
				</form:form>
					</c:if>
			<hr>
			<security:authorize access="hasRole('ADMIN')">		
				<div class="container text-left">
	
					<a href="/products/new" class="btn btn-success">Add
						New Product</a>
				</div>
			</security:authorize>
			<br>
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>ID</th>
						<th>Name</th>
						<th>Category</th>
						<th>Quantity</th>
						<th>Price</th>
						<th>Subtotal</th>
						<security:authorize access="hasAnyRole('ADMIN', 'USER')">
						<th>Actions</th>
						</security:authorize>
					</tr>
				</thead>
				<tbody>

					<c:choose>
					<c:when test = "${!search}">
					<c:forEach var="product" items="${productList}">
						<tr>
							<td>${product.id}</td>
							<td>${product.name}</td>
							<td>${product.category}</td>
							<td>${product.quantity}</td>
							<td>$${String.format("%.2f",product.price)}</td>
							<td>$${String.format("%.2f",product.quantity * product.price)}</td>
							<td>
								<security:authorize access="hasAnyRole('ADMIN', 'USER')">
								<a href="/products/edit/${product.id}" class="btn btn-secondary">Edit</a>
								<security:authorize access="hasRole('ADMIN')">
									<a href="/products/delete/${product.id}" class="btn btn-danger">Delete</a>
								</security:authorize>
							</security:authorize>
							</td>
						</tr>
					</c:forEach>
					
					<security:authorize access="hasRole('ACC')">
						<tr>
						<td>Subtotal: </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>$${String.format("%.2f", total)}</td>
					</tr>
					
					
					<table align="right">
				<tbody style="font-size:40px; color:blue;">
					
					<tr>
						<td>Total: </td>
						<td>$${String.format("%.2f", total*1.06)}</td>
					</tr>
					
				</tbody>

			</security:authorize>
			</table>
					</c:when>
					<c:otherwise>
					<c:forEach var="product" items="${searched}">
						<tr>
							<td>${product.id}</td>
							<td>${product.name}</td>
							<td>${product.category}</td>
							<td>${product.quantity}</td>
							<td>$${String.format("%.2f",product.price)}</td>
							<td>$${String.format("%.2f",product.quantity * product.price)}</td>
							<td>
								<security:authorize access="hasAnyRole('ADMIN', 'USER')">
								<a href="/products/edit/${product.id}" class="btn btn-secondary">Edit</a>
								<security:authorize access="hasRole('ADMIN')">
									<a href="/products/delete/${product.id}" class="btn btn-danger">Delete</a>
								</security:authorize>
							</security:authorize>
							</td>
						</tr>
						</c:forEach>
					
		<security:authorize access="hasRole('ACC')">
					
					<tr>
						<td>Subtotal: </td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>$${String.format("%.2f", total)}</td>
					</tr>
				</tbody>
			</table>
			
			<table align="right">
				<tbody style="font-size:40px; color:blue;">
					
					<tr>
						<td>Total: </td>
						<td>$${String.format("%.2f", total*1.06)}</td>
					</tr>
					
				</tbody>

			</table>
			</security:authorize>
			<br>
				<a href="/products" class="btn btn-danger">Back</a>
			
			</c:otherwise>
		</c:choose>
		
		</div>
	</div>
</body>
</html>
