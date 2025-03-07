<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/header.jsp"/>

<div style="width: 100%; display: flex; justify-content: center; align-items: center; padding: 40px 20px;">
    <div style="width: 100%; max-width: 500px; box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1); padding: 40px 20px; border-radius: 20px;">
        <div style="width: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
            <div class="text-primary" style="font-size: 20px; font-weight: bold;">
                Login
            </div>
            <div style="font-size: 16px;">
                Login with your account
            </div>
        </div>

        <form action="auth?action=login" method="post">
            <div class="mb-3 mt-3">
                <label for="email" class="form-label">Email:</label>
                <input type="text" class="form-control" id="email" placeholder="Enter email" name="email">
                <span class="text-danger">${not empty errors.email ? errors.email : ''}</span>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" placeholder="Enter password" name="password">
                <span class="text-danger">${not empty errors.password ? errors.password : ''}</span>
            </div>
            <div class="mb-4" style="width: 100%; display: flex; justify-content: flex-end;">
                <a href="" class="text-decoration-none text-primary">
                    Forgot password?
                </a>
            </div>
            <button type="submit" class="btn btn-primary mb-3" style="width: 100%">Login</button>
            <div style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 6px;">
                <span>
                    Don't have an account?
                </span>
                <a class="text-decoration-none text-primary" href="auth?action=register">
                    Register
                </a>
            </div>
        </form>

    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>
