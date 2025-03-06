<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3>Account</h3>
        </div>
        <div class="card-body">
            <form method="post" action="Management/account?action=edit">
                <input type="hidden" name="id" value="${not empty formData.id ? formData.id : ''}">
                <input type="hidden" name="email" value="${not empty formData.email ? formData.email : ''}">
                <input type="hidden" name="password" value="${not empty formData.password ? formData.password : ''}">
                <input type="hidden" name="role" value="${not empty formData.role ? formData.role : ''}">

                <div class="row g-3">
                    <div class="col-md-12">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" placeholder="Enter full name" value="${not empty formData.fullName ? formData.fullName : ''}">
                        <span class="text-danger">${not empty errors.fullName ? errors.fullName : ''}</span>
                    </div>
                </div>

                <div class="row g-3 mt-2">
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" placeholder="Enter email" disabled value="${not empty formData.email ? formData.email : ''}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Phone</label>
                        <input type="text" class="form-control" name="phone" placeholder="Enter phone number" value="${not empty formData.phone ? formData.phone : ''}">
                        <span class="text-danger">${not empty errors.phone ? errors.phone : ''}</span>
                    </div>
                </div>

                <div class="mt-3">
                    <label class="form-label">Address</label>
                    <textarea class="form-control" name="address" rows="2" placeholder="Enter address">${not empty formData.address ? formData.address : ''}</textarea>
                    <span class="text-danger">${not empty errors.address ? errors.address : ''}</span>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">Submit</button>
                </div>
            </form>
        </div>
    </div>
</div>