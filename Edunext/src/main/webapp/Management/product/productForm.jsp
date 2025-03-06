<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Product</h3>
        </div>
        <div class="card-body">
            <form method="post" action="Management/product?action=<%= request.getAttribute("id") == null ? "add" : "edit"%>" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>">

                <div class="row g-3">
                    <!-- Product Name -->
                    <div class="col-md-6">
                        <label class="form-label">Product Name</label>
                        <input type="text" class="form-control" name="name" placeholder="Enter product name" value="<%= request.getAttribute("productName") != null ? request.getAttribute("productName") : ""%>" required>
                    </div>

                    <!-- Product Image -->
                    <div class="col-md-6">
                        <label class="form-label">Product Image</label>
                        <input type="file" class="form-control" name="image" accept="image/*" <%= request.getAttribute("imageFile") == null ? "required" : ""%>>
                    </div>

                    <!-- Brand -->
                    <div class="mb-3">
                        <label for="brand" class="form-label">Brand:</label>
                        <select class="form-control" id="brand" name="brand_id" required>
                            <c:forEach var="b" items="${brands}">
                                <c:if test="${b.status == true}">
                                    <option value="${b.id}" 
                                            <c:if test="${b.id == requestScope.brandId}">selected</c:if>>
                                        ${b.name}
                                    </option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label for="category" class="form-label">Category:</label>
                        <select class="form-control" id="category" name="category_id" required>
                            <c:forEach var="c" items="${cates}">
                                <option value="${c.id}" 
                                        <c:if test="${c.id == requestScope.categoryId}">selected</c:if>>
                                    ${c.name}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Price -->
                    <div class="col-md-4">
                        <label class="form-label">Price ($)</label>
                        <input type="number" class="form-control" name="price" placeholder="Enter price" value="<%= request.getAttribute("price") != null ? request.getAttribute("price") : ""%>" required min="1">
                    </div>

                    <!-- Quantity -->
                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" class="form-control" name="quantity" placeholder="Enter quantity" value="<%= request.getAttribute("quantity") != null ? request.getAttribute("quantity") : ""%>" required min="1">
                    </div>

                    <!-- Product Description -->
                    <div class="col-md-12">
                        <label class="form-label">Description</label>
                        <textarea class="form-control" name="description" rows="4" placeholder="Enter product description" required><%= request.getAttribute("description") != null ? request.getAttribute("description") : ""%></textarea>
                    </div>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">Submit</button>
                    <button type="reset" class="btn btn-secondary px-4 ms-2">Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>
