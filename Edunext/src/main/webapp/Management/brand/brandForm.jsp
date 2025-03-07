<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Brand</h3>
        </div>
        <div class="card-body">
            <form method="post"
                  class="form-action"
                  data-option="brand"
                  data-action="<%= request.getAttribute("id") == null ? "add" : "edit"%>"
                  enctype="multipart/form-data">
                <input type="hidden" name="id" value="<%= request.getAttribute("id") != null ? request.getAttribute("id") : ""%>">

                <div class="mb-3">
                    <label class="form-label">Brand Name</label>
                    <input type="text" class="form-control" name="name" placeholder="Enter brand name"
                           value="<%= request.getAttribute("name") != null ? request.getAttribute("name") : ""%>" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Brand Image</label>
                    <input type="file" class="form-control" name="image" accept="image/*">
                    <% if (request.getAttribute("image") != null && !request.getAttribute("image").toString().isEmpty()) {%>
                    <div class="mt-2">
                        <img src="<%= request.getContextPath()%>/<%= request.getAttribute("image")%>" 
                             alt="Current Brand Image" width="100">
                    </div>
                    <% }%>
                </div>

                <div class="text-center mt-4">
                    <button type="submit" class="btn btn-success px-4">Submit</button>
                    <button data-option="brand" data-action="list" class="btn btn-secondary btn-action px-4 ms-2">Cancel</button>
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
                preview.style.display = "block";  
            };
            reader.readAsDataURL(fileInput.files[0]);
        }
    }
</script>