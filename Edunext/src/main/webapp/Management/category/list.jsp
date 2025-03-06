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
            Category List
        </h2>
        <button class="btn-action" data-option="category" data-action="add"
                style="
                padding: 10px 15px;
                background-color: #008CBA;
                color: white;
                border: none;
                cursor: pointer;
                border-radius: 5px;
                transition: background-color 0.3s ease;
                "
                onmouseover="this.style.backgroundColor = '#005f73'"
                onmouseout="this.style.backgroundColor = '#008CBA'">
            Create New Category
        </button>
    </div>

    <table border="1" 
           style="
           width: 100%;
           border-collapse: collapse;
           margin-top: 15px;
           background-color: white;
           ">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">STT</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Image</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Name</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Actions</th>
            </tr>
        </thead>
        <tbody>
            <!-- Loop through categories fetched from database -->
            <c:forEach var="category" items="${cates}">
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 12px; border: 1px solid #ccc;">${category.id}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">
                        <img src="${category.image}" alt="Image" width="100" class="img-thumbnail"">
                    </td>
                    <td style="padding: 12px; border: 1px solid #ccc;">${category.name}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">
                        <button class="btn-action" data-option="category" data-action="edit" data-id="${category.id}"
                                style="
                                padding: 8px 12px;
                                background-color: #4CAF50;
                                color: white;
                                border: none;
                                cursor: pointer;
                                border-radius: 5px;
                                margin-right: 20px;
                                transition: background-color 0.3s ease;
                                "
                                onmouseover="this.style.backgroundColor = '#388e3c'"
                                onmouseout="this.style.backgroundColor = '#4CAF50'"
                                onclick="window.location.href = 'Management/category?action=edit&id=${category.id}'">
                            Edit
                        </button>
                        <button class="btn-action" data-option="category" data-action="delete" data-id="${category.id}"
                                style="
                                padding: 8px 12px;
                                background-color: #f44336;
                                color: white;
                                border: none;
                                cursor: pointer;
                                border-radius: 5px;
                                transition: background-color 0.3s ease;
                                "
                                onmouseover="this.style.backgroundColor = '#d32f2f'"
                                onmouseout="this.style.backgroundColor = '#f44336'">
                            Delete
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
