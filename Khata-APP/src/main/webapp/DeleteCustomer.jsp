<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="customer.CustomerDAO" %>
<%@ page import="customer.CustomerPojo" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Customer</title>
<style>
table {
	width: 100%;
	border-collapse: collapse;
	border : 2px solid black;
	border-radius: 10px;
}

tr:hover {
	background-color: cyan;
	color:black;
	
}

th, td {
	padding: 8px;
	text-align: left;
	border-bottom: 1px solid black;
	
}

th {
	background-color: #f2f2f2;
	color:black;
}

@media screen and (max-width: 400px) {
	th, td {
		font-size: 14px;
	}
}
body{
 background:lightcyan;
}
.a1 .btn{
	color:black;
	background-color:cyan;
	border:2px solid black;
	font-size:30px;
	font-style:italic;
	font-weight:600;
	border-radius:10px;
}
</style>
</head>
<body >
    <h1>Delete Customer</h1>
    <table border="1">
        <thead>
            <tr>
                <th>Customer Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                int currentLoginUserId = (int) request.getSession().getAttribute("CurrentLoginUserId");
                
                // Use the CustomersDAO to retrieve customer data based on currentLoginUserId
                CustomerDAO customersDAO = new CustomerDAO();
                List<CustomerPojo> customers = customersDAO.getCustomersByUserId(currentLoginUserId);

                for (CustomerPojo customer : customers) {
            %>
                <tr>
                    <td><%= customer.getCustomerName() %></td>
                    <td>
                        <form action="DeleteCustomerServlet" method="post">
                            <input type="hidden" name="customerName" value="<%= customer.getCustomerName() %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <br>
    <a class="a1" href="Customer.jsp"><input class="btn btn-primary" type="button" value="Go Back"></a>
</body>
</html>
