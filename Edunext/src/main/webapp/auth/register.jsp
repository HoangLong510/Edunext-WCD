<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/header.jsp"/>

<div style="width: 100%; display: flex; justify-content: center; align-items: center; padding: 40px 20px;">
    <div style="width: 100%; max-width: 550px; box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1); padding: 40px 20px; border-radius: 20px;">
        <div style="width: 100%; display: flex; flex-direction: column; justify-content: center; align-items: center;">
            <div class="text-primary" style="font-size: 20px; font-weight: bold;">
                Register
            </div>
            <div style="font-size: 16px;">
                Register your account
            </div>
        </div>

        <form action="auth?action=register" method="post">
            <div class="mb-3 mt-3">
                <label for="fullName" class="form-label">Full name:</label>
                <input type="text" class="form-control" id="fullName" placeholder="Enter full name" name="fullName" value="${not empty userData.fullName ? userData.fullName : ''}">
                <span class="text-danger">${not empty errors.fullName ? errors.fullName : ''}</span>
            </div>
            <div class="mb-3 mt-3">
                <label for="email" class="form-label">Email:</label>
                <input type="text" class="form-control" id="email" placeholder="Enter email" name="email" value="${not empty userData.email ? userData.email : ''}">
                <span class="text-danger">${not empty errors.email ? errors.email : ''}</span>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" placeholder="Enter password" name="password">
                <span class="text-danger">${not empty errors.password ? errors.password : ''}</span>
            </div>
            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm Password:</label>
                <input type="password" class="form-control" id="confirmPassword" placeholder="Enter confirm password" name="confirmPassword">
                <span class="text-danger">${not empty errors.confirmPassword ? errors.confirmPassword : ''}</span>
            </div>
            <div class="mb-3 mt-3">
                <label for="phone" class="form-label">Phone:</label>
                <input type="text" class="form-control" id="phone" placeholder="Enter phone" name="phone" value="${not empty userData.phone ? userData.phone : ''}">
                <span class="text-danger">${not empty errors.phone ? errors.phone : ''}</span>
            </div>
            <div class="mb-4 mt-3">
                <label for="address" class="form-label">Address:</label>
                <input type="text" class="form-control" id="address" placeholder="Enter address" name="address" value="${not empty userData.address ? userData.address : ''}">
                <span class="text-danger">${not empty errors.address ? errors.address : ''}</span>
            </div>
            <button type="submit" class="btn btn-primary mb-3" style="width: 100%">Register</button>
            <div style="width: 100%; display: flex; align-items: center; justify-content: center; gap: 6px;">
                <span>
                    You already have an account?
                </span>
                <a class="text-decoration-none text-primary" href="auth?action=login">
                    Login
                </a>
            </div>
        </form>

    </div>
</div>

<jsp:include page="/includes/footer.jsp"/>
