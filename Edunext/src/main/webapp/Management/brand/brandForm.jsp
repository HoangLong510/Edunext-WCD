<div class="container mt-5">
    <div class="card shadow-lg">
        <div class="card-header bg-primary text-white text-center">
            <h3><%= request.getAttribute("id") == null ? "Add" : "Edit"%> Brand</h3>
        </div>
        <div class="card-body">
            <form method="post" action="<%= request.getContextPath()%>/Management/brand?action=<%= request.getAttribute("id") == null ? "add" : "edit"%>"
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
                    <button type="reset" class="btn btn-secondary px-4 ms-2">Reset</button>
                </div>
            </form>
        </div>
    </div>
</div>
