<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

    <div class="container mt-3">
        <h2>Category Add Form</h2>
        <form action="/Management/category" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3 mt-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control"
                       placeholder="Enter name" name="name">
            </div>
            <div class="mb-3 mt-3">
                <label for="brandId" class="form-label">Brand</label>
                <select class="form-select" name="brandId">
                    <c:forEach var="b" items="${brands}">
                        <option value="${b.id}">${b.name}</option>
                    </c:forEach>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
