<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div style="
     width: 100%;
     padding: 20px;
     border: 1px solid #ddd;
     border-radius: 10px;
     background-color: #f9f9f9;
     box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
     font-family: Arial, sans-serif;
     ">
    <div style="
         display: flex;
         justify-content: space-between;
         align-items: center;
         flex-wrap: wrap;
         padding-bottom: 10px;
         border-bottom: 2px solid #ddd;
         ">
        <h2 style="
            color: #333;
            margin: 0 auto;
            text-align: center;
            flex-grow: 1;
            ">
            Brand List
        </h2>

        <button class="btn-action" data-option="brand" data-action="add"
                style="
                padding: 10px 15px;
                background-color: #008CBA;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                transition: 0.3s;
                "
                onmouseover="this.style.backgroundColor = '#005f73'"
                onmouseout="this.style.backgroundColor = '#008CBA'">
            Create New Brand
        </button>

        <div class="container mt-3">
            <div class="card shadow-sm" style="width: 20%; min-width: 250px;">
                <div class="card-body">
                    <h5 class="card-title">Filter by Status</h5>
                    <form method="get" action="${pageContext.request.contextPath}/Management/brand">
                        <select name="status" class="form-control" id="status" onchange="this.form.submit()">
                            <option value="">--All--</option>
                            <option value="true" ${status == 'true' ? 'selected' : ''}>Active</option>
                            <option value="false" ${status == 'false' ? 'selected' : ''}>Inactive</option>
                        </select>
                        <input type="hidden" name="action" value="sort"/>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table border="1" 
           style="
           width: 100%;
           border-collapse: collapse;
           margin-top: 15px;
           background: white;
           ">
        <thead>
            <tr style="background-color: #f2f2f2 ; table-layout: fixed;">
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd; width: 10%;">STT</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd; width: 20%;">Image</th>
                <th style="padding: 8px; text-align: left; border-bottom: 2px solid #ddd; width: 25%;">Name</th>
                <th style="padding: 8px; text-align: left; border-bottom: 2px solid #ddd; width: 25%;">Status</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd; width: 20%;">Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="brand" items="${brands}">
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 12px; border: 1px solid #ccc;">${brand.id}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">
                        <img src="${brand.image}" alt="Image"  width="100" class="img-thumbnail""/>
                    </td>
                    <td style="padding: 8px; border: 1px solid #ccc;">${brand.name}</td>
                    <td style="padding: 8px; border: 1px solid #ccc;">
                        ${brand.status ? 'Active' : 'Inactive'}
                    </td>
                    <td style="padding: 12px; border: 1px solid #ccc;display: flex;">
                        <button class="btn-action" data-option="brand" data-action="edit" data-id="${brand.id}"
                                style="
                                padding: 8px 12px;
                                background-color: #4CAF50;
                                color: white;
                                border: none;
                                cursor: pointer;
                                border-radius: 5px;
                                margin-right: 20px;
                                transition: 0.3s;
                                "
                                onmouseover="this.style.backgroundColor = '#388e3c'"
                                onmouseout="this.style.backgroundColor = '#4CAF50'"
                                onclick="window.location.href = 'Management/brand?action=edit&id=${brand.id}'">
                            Edit
                        </button>

                        <form method="post" action="${pageContext.request.contextPath}/Management/brand">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="id" value="${brand.id}">
                            <button type="submit" class="btn-action"
                                    style="
                                    padding: 8px 12px;
                                    background-color: #f44336;
                                    color: white;
                                    border: none;
                                    cursor: pointer;
                                    border-radius: 5px;
                                    transition: 0.3s;
                                    "
                                    onmouseover="this.style.backgroundColor = '#d32f2f'"
                                    onmouseout="this.style.backgroundColor = '#f44336'">
                                Delete
                            </button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
