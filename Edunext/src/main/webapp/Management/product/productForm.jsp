<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Product</h3>
        </div>
        <div class="card-body">
            <form method="post" action="Management/product?action=add" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>">

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label">Product Name</label>
                        <input type="text" class="form-control" name="name" placeholder="Enter product name" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Product Image</label>
                        <input type="file" class="form-control" name="image" accept="image/*" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Brand</label>
                        <select class="form-select" name="brand" required>
                            <option value="" selected disabled>Select a brand</option>
                            <option value="1">Brand A</option>
                            <option value="2">Brand B</option>
                            <option value="3">Brand C</option>
                        </select>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label">Category</label>
                        <select class="form-select" name="category" required>
                            <option value="" selected disabled>Select a category</option>
                            <option value="1">Category A</option>
                            <option value="2">Category B</option>
                            <option value="3">Category C</option>
                        </select>
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Price ($)</label>
                        <input type="number" class="form-control" name="price" placeholder="Enter price" required min="1">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Quantity</label>
                        <input type="number" class="form-control" name="quantity" placeholder="Enter quantity" required min="1">
                    </div>

                    <div class="col-md-4">
                        <label class="form-label">Color</label>
                        <input type="text" class="form-control" name="color" placeholder="Enter color" required>
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
