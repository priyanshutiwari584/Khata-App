<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="customer.CustomerPojo"%>
<%@page import="customer.CustomerDAO"%>
<%@page import="items.ItemDAO"%>
<%@page import="items.ItemPojo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Invoice Customer</title>
<!-- CSS StyleSheet -->

<!-- Jquery cdn -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<!-- For Calculating Total and Balance Amount -->
<script type="text/javascript">
function calculateTotal() {
    var sellPrice = parseFloat(document.getElementById("SellPrice").value);
    var quantity = parseFloat(document.getElementById("quantity").value);
    var total = sellPrice * quantity;
    document.getElementById("total").value = total.toFixed(2);
}

function calculateBalance() {
    var total = parseFloat(document.getElementById("total").value);
    var amountPaid = parseFloat(document.getElementById("amountPaid").value);
    var balance = total - amountPaid;
    document.getElementById("balance").value = balance.toFixed(2);
}
</script>
<!-- ... Other parts of the invoiceCustomer.jsp ... -->

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $('#CustomerName').change(function () {
            var selectedCustomerName = $(this).val();

            $.ajax({
                url: 'GetCustomerDetailsServlet', // Your servlet URL
                method: 'GET',
                data: { customerName: selectedCustomerName },
                success: function (data) {
                    // Assuming data is a JSON object with customer information
                    $('#CustomerNumber').val(data.customerNumber);
                    $('#CustomerEmail').val(data.customerEmail);
                    $('#CustomerAddress').val(data.customerAddress);
                },
                error: function () {
                    console.error('Error fetching customer details');
                }
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('#prodId').change(function () {
            var selectedProdId = $(this).val();

            $.ajax({
                url: 'GetProductDetailsServlet',
                method: 'GET',
                data: { prodId: selectedProdId },
                success: function (data) {
                    $('#ProdName').val(data.prodName);
                    $('#SellPrice').val(data.sellPrice);
                    // Rest of your code
                },
                error: function () {
                    console.error('Error fetching product details');
                }
            });
        });
    });
</script>

<!-- Script for handling the radio button events and redirecting to another page -->
<script type="text/javascript">
function handleRadioClick(radioValue) {
    var redirectUrl;

    // Determine the redirect URL based on the selected radio button value
    if (radioValue === "Card") {
        redirectUrl = "Card1.jsp"; // Replace with the URL for the first page
    } else if (radioValue === "Online") {
        redirectUrl = "Online1.jsp"; // Replace with the URL for the second page
    }

    // Open the determined URL in a new tab/window
    if (redirectUrl) {
        window.open(redirectUrl, '_blank');
    }
}
</script>

</head>
<body>
<div>
	<%int currentLoginUserId = (int)request.getSession().getAttribute("CurrentLoginUserId"); %>
	<form action="AddInvoiceCustomerServlet" method="post">
		<label for="CustomerName">Supplier Name:</label>
		 <select name="CustomerName" id="CustomerName">
			<option value="">Select Customer</option>
			<!-- Populate with customer names from the customers table -->
			<%
			CustomerDAO customerDAO = new CustomerDAO();
			List<CustomerPojo> customerList = customerDAO.getCustomersByUserId(currentLoginUserId); // Replace with your method to retrieve all customers
			for (CustomerPojo customer : customerList) {
			%>
			<option value="<%=customer.getCustomerName()%>"><%=customer.getCustomerName()%></option>
			<%
			}
			%>
		</select> <br>
		<label for="CustomerNumber">Supplier Number:</label>
		 <input type="text" name="CustomerNumber" id="CustomerNumber" readonly><br>

		<label for="CustomerEmail">Supplier Email:</label>
		 <input type="text"  name="CustomerEmail" id="CustomerEmail" readonly><br>
		 
		 <label for="CustomerAddress">Supplier Address:</label> 
		 <input type="text" name="CustomerAddress" id="CustomerAddress" readonly><br>

		<label for="prodId">Product ID:</label>
		 <select name="prodId" id="prodId">
			<option value="">Select Product</option>
			<!-- Populate with product IDs from the items table -->
			<%
			ItemDAO itemDAO = new ItemDAO();
			List<ItemPojo> itemList = itemDAO.getItemsByUserId(currentLoginUserId); // Replace with your method to retrieve all items
			for (ItemPojo item : itemList) {
			%>
			<option value="<%=item.getProdId()%>"><%=item.getProdId()%></option>
			<%
			}
			%>
		</select> <br>
		<label for="ProdName">Product Name:</label>
		 <input type="text" name="ProdName" id="ProdName" readonly><br>
		 
		<label for="sellPrice">Selling Price:</label> 
		<input type="text" name="SellPrice" id="SellPrice" readonly><br>
		
		<label for="Quantity">Quantity:</label>
		<input type="text" name="quantity" id="quantity" placeholder="Quantity" oninput="calculateTotal();"><br>
		
		<label for="Quantity">Total:</label>
		<input type="text" name="total" id="total" placeholder="Total" readonly><br>
		
		<label for="Quantity">Amount Paid:</label>
		<input type="text" name="amountPaid" id="amountPaid" placeholder="AmountPaid" oninput="calculateBalance();"><br>
		
		<label for="Quantity">Balance:</label>
		<input type="text" name="balance" id="balance" placeholder="Balance" readonly><br>
		
		<input type="radio" id="PaymentMode" name="PaymentMode" value="Cash">
		<label for="Cash">Cash</label><br>
		
        <label for="radioOption1">
            <input type="radio" id="radioOption1" name="PaymentMode" value="Card" onclick="handleRadioClick('Card')"> Card
        </label>
        <label for="radioOption2">
            <input type="radio" id="radioOption2" name="PaymentMode" value="Online" onclick="handleRadioClick('Online')"> Online
        </label>
    	
		
		<br>
		<input type="submit" value="Generate Invoice">
	</form>
</div>
<br>
	<a class="a1" href="Sales.jsp"><input class="btn btn-primary" type="button" value="Go back"></a>
    
</body>
</html>
