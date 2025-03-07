<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Notification</title>
    </head>
    <body style="font-family: Arial, sans-serif; background-color: #f4f4f4; padding: 20px; text-align: center;">
        <div style="max-width: 600px; margin: auto; background: #ffffff; padding: 20px; border-radius: 12px;
             box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); text-align: left;">


            <div style="background: linear-gradient(135deg, #6a11cb, #2575fc); padding: 20px;
                 border-top-left-radius: 12px; border-top-right-radius: 12px;
                 color: white; font-size: 20px; font-weight: bold; text-align: center;">
                Payment Notification
            </div>


            <div style="padding: 20px; color: #333; font-size: 16px;">
                <p style="margin: 0 0 10px;">Dear ${name},</p>
                <p style="margin: 0 0 15px;">We are pleased to inform you that your payment has been successfully processed. Below are your order details:</p>

                <div style="font-size: 16px; color: #333;">
                    <p><strong>Order ID:</strong> ${orderId}</p>
                    <p><strong>Recipient Name:</strong> ${name}</p>
                    <p><strong>Phone Number:</strong> ${phone}</p>
                    <p><strong>Address:</strong> ${address}</p>
                    <p><strong>Total Amount:</strong> ${total}</p>
                    <p style="font-size: 18px; font-weight: bold; color: #2575fc;">Paid Successfully</p>
                </div>

                <p style="font-size: 14px; color: #777; text-align: center;">
                    If you have any questions or concerns, please feel free to contact us.
                </p>
            </div>
        </div>
    </body>
</html>
