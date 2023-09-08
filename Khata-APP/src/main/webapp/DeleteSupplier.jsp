<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="supplier.SupplierDAO" %>
<%@ page import="supplier.SupplierPojo" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Supplier</title>
    
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
 background: lightcyan;
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
<body>
    <h1>Delete Supplier</h1>
    
    <table border="1">
        <thead>
            <tr>
                <th>Supplier Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            
            
            <%
            	int currentLoginUserId = (int)request.getSession().getAttribute("CurrentLoginUserId");
                SupplierDAO supplierDAO = new SupplierDAO();
                List<SupplierPojo> suppliers = supplierDAO.getAllSuppliersByUserId(currentLoginUserId);
                
                for (SupplierPojo supplier : suppliers) {
            %>
                <tr>
                    <td><%= supplier.getSupplierName() %></td>
                    <td>
                        <form action="DeleteSupplierServlet" method="post">
                            <input type="hidden" name="supplierName" value="<%= supplier.getSupplierName() %>">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <br>
    <a class="a1" href="Supplier.jsp"><input class="btn btn-primary" type="button" value="Go Back"></a>
</body>
</html>
