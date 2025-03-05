<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Category</h3>
        </div>
        <div class="card-body">
            <form method="post" action="Management/category?action=add" enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>">

                <div class="mb-3">
                    <label class="form-label">Category Name</label>
                    <input type="text" class="form-control" name="name" placeholder="Enter category name" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Category Image</label>
                    <input type="file" class="form-control" name="image" accept="image/*" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Product</label>
                    <select class="form-select" name="product" required>
                        <option value="" selected disabled>Select a product</option>
                        <option value="1">Product A</option>
                        <option value="2">Product B</option>
                        <option value="3">Product C</option>
                    </select>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">Submit</button>
                    <button type="reset" class="btn btn-secondary px-4 ms-2">Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>