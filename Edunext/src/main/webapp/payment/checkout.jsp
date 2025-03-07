<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Checkout</title>
    <style>
        .checkout-container {
            display: flex;
            justify-content: center;
        }
        .checkout-section {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            margin: 10px;
            background-color: #f9f9f9;
        }
        .qr-code img {
            max-width: 100%;
            height: auto;
        }
        .text-center-bold {
            text-align: center;
            font-weight: bold;
        }
        .info-key {
            display: inline-block;
            width: 230px;
        }
        .info-value {
            display: inline-block;
            font-weight: bold;
        }
        .info-line {
            border-bottom: 1px solid #ddd;
            padding-bottom: 15px;
            margin-bottom: 15px;
        }
    </style>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <div class="modal fade" id="popup" tabindex="-1" aria-labelledby="popupLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="popupLabel">Thanh toán thành công</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Đơn hàng của bạn đã được thanh toán thành công.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-success" data-bs-dismiss="modal">OK</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"></script>
    <script>
        function showSuccessPopup() {
            var modal = new bootstrap.Modal(document.getElementById('popup'));
            modal.show();
            setTimeout(function() {
                window.location.href = '/Edunext/payment/orderForm.jsp'; 
            }, 3000); 
        }
        function checkPaymentStatus() {
            $.ajax({
                url: '/Edunext/checkpaymentstatus', 
                method: 'GET',
                data: { orderId: '<%= request.getParameter("id") %>' }, 
                success: function(response) {
                    if (response.success) {
                        showSuccessPopup();
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Lỗi khi kiểm tra trạng thái thanh toán:", error);
                }
            });
        }
        setInterval(checkPaymentStatus, 5000);
    </script>
</head>
<body>

<jsp:include page="/includes/header.jsp"/>

    <div class="container mt-5">
        <h2 class="text-center">Checkout</h2>
        <div class="checkout-container">
            <div class="checkout-section col-md-5 qr-code">
                <h3>Scan the QR Code to Pay</h3>
                <p>Please scan the QR code below to complete your payment:</p>
                <img src="https://qr.sepay.vn/img?bank=MBBank&acc=0648205896666&template=compact&amount=${order.total}&des=DH${order.id}" class="img-fluid" alt="QR Code">
                <p>Status: Waiting for payment...</p>
            </div>
            <div class="checkout-section col-md-5">
                <h3>Bank Transfer Information</h3>
                <p class="text-center-bold">Bank: MBBank</p>
                <p class="info-line"><span class="info-key">Account Holder:</span> <span class="info-value">NGUYEN ANH MINH</span></p>
                <p class="info-line"><span class="info-key">Account Number:</span> <span class="info-value">0648205896666</span></p>
                <p class="info-line"><span class="info-key">Amount:</span> <span class="info-value">${order.total}</span></p>
                <p class="info-line"><span class="info-key">Transfer Content:</span> <span class="info-value">DH${order.id}</span></p>
                <p class="text-danger"><strong>Note:</strong> Please keep the transfer content as DH${order.id} for the system to automatically confirm the payment.</p>
            </div>
        </div>
    </div>

<jsp:include page="/includes/footer.jsp"/>

<script src="/Edunext/assets/js/category_scroll.js" defer></script>
<script src="/Edunext/assets/js/ajax_dynamic_loading.js" defer></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

</body>
</html>
