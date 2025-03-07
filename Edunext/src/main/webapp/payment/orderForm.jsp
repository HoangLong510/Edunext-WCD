<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Order Page</title>
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

    <div class="container mt-5">
        <h2>Order Form</h2>
        <form action="/Edunext/order" method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Recipient Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Phone Number</label>
                <input type="number" class="form-control" id="phone" name="phone" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <input type="text" class="form-control" id="address" name="address" required>
            </div>
            <div class="mb-3">
                <label for="total" class="form-label">Total Amount</label>
                <input type="number" class="form-control" id="total" name="total" required>
            </div>
            <button type="submit" class="btn btn-primary">Place Order</button>
        </form>
    </div>

<jsp:include page="/includes/footer.jsp"/>

</body>
</html>
