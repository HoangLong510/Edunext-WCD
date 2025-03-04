<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<main>
    <div class="container mt-3">
        <h2>Product Add Form</h2>
        <form action="product?action=add" method="post">
            <div class="mb-3 mt-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control"
                       placeholder="Enter name" name="name">
            </div>
            <div class="mb-3 mt-3">
                <label for="name" class="form-label">Price</label>
                <input type="text" class="form-control"
                       placeholder="Enter price" name="price">
            </div>
            <div class="mb-3 mt-3">
                <label for="categoryId" class="form-label">Category</label>
                <select class="form-select" name="categoryId">
                    <c:forEach var="c" items="${cates}">
                        <option value="${c.id}">${c.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</main>
