
<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Category</h3>
        </div>
        <div class="card-body">
            <form method="post"
                  class="form-action"
                  data-option="category"
                  data-action="<%= request.getAttribute("id") == null ? "add" : "edit"%>"
                  enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>">

                <!-- Category Name -->
                <div class="mb-3">
                    <label class="form-label">Category Name</label>
                    <input type="text" class="form-control" name="name" placeholder="Enter category name"
                           value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : ""%>" required>
                </div>

                <!-- Category Image -->
                <div class="mb-3">
                    <label class="form-label">Category Image</label>
                    <input type="file" class="form-control" name="image" accept="image/*" id="imageInput" onchange="previewImage()">

                    <div class="mt-2">
                        <img id="imagePreview" 
                             src="<%= (request.getAttribute("image") != null && !request.getAttribute("image").toString().isEmpty())
                                     ? request.getContextPath() + "/" + request.getAttribute("image")
                                     : '#'%>" 
                             alt="Current Category Image" 
                             width="150"
                             style="display: <%= (request.getAttribute("image") != null && !request.getAttribute("image").toString().isEmpty())
                                     ? "block"
                                     : "none"%>;">
                    </div>
                    <small class="form-text text-muted">Leave empty to keep the current image</small>
                </div>

                <!-- Brand Selection -->
                <div class="mb-3">
                    <label for="brand" class="form-label">Brand:</label>
                    <select class="form-control" id="brand" name="brand_id" required>
                        <c:forEach var="b" items="${brands}">
                            <p>Brand ID: ${b.id}, Selected ID: ${categoryBrandId}</p>
                            <option value="${b.id}" ${b.id == categoryBrandId ? 'selected="selected"' : ''}>
                                ${b.name}
                            </option>
                        </c:forEach>
                    </select>
                </div>


                <!-- Buttons -->
                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">Submit</button>
                    <button data-option="category" data-action="list" class="btn btn-secondary btn-action px-4 ms-2">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function previewImage() {
        const fileInput = document.getElementById("imageInput");
        const preview = document.getElementById("imagePreview");

        if (fileInput.files && fileInput.files[0]) {
            const reader = new FileReader();
            reader.onload = function (e) {
                preview.src = e.target.result;
                preview.style.display = "block";  // Hi?n th? ?nh khi ng??i dùng ch?n t?p m?i
            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
</script>
