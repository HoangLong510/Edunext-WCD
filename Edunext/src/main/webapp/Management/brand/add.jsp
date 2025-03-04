<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div style="min-height: 100%;
     width: 100%;
     margin: 0 auto;
     padding: 20px;
     background-color: white;
     border-radius: 10px;
     box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
    <div class="container mt-3">
        <h2>Product Add Form</h2>
        <form action="Product?action=add" method="post">
            <div class="mb-3 mt-3">
                <label for="name" class="form-label">Name</label>
                <input type="text" class="form-control" placeholder="Enter name" name="name">
            </div>
            <div class="mb-3 mt-3">
                <label for="logo" class="form-label">Logo</label>
                <input type="text" class="form-control" placeholder="Enter logo" name="logo">
            </div>
            <div class="mb-3 mt-3">
                <label for="description" class="form-label">Description</label>
                <textarea class="form-control" placeholder="Enter description" name="description"></textarea>
            </div>
            <div class="mb-3 mt-3">
                <label for="price" class="form-label">Price</label>
                <input type="number" class="form-control" placeholder="Enter price" name="price">
            </div>
            <div class="mb-3 mt-3">
                <label for="quantity" class="form-label">Quantity</label>
                <input type="number" class="form-control" placeholder="Enter quantity" name="quantity">
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>
</div>