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
            Account Management
        </h2>
<!--        <button class="btn-action" data-option="account" data-action="add"
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
            Create New Account
        </button>-->
    </div>

    <table border="1" 
           style="
           width: 100%;
           border-collapse: collapse;
           margin-top: 15px;
           background: white;
           ">
        <thead>
            <tr style="background-color: #f2f2f2;">
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">STT</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Full name</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Email</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Phone</th>
                <th style="padding: 12px; text-align: left; border-bottom: 2px solid #ddd;">Role</th>
                <th style="padding: 12px; text-align: right; border-bottom: 2px solid #ddd;">Action</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="u" items="${users}">
                <tr style="border-bottom: 1px solid #ddd;">
                    <td style="padding: 12px; border: 1px solid #ccc;">${u.id}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">${u.fullName}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">${u.email}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">${u.phone}</td>
                    <td style="padding: 12px; border: 1px solid #ccc;">${u.role}</td>
                    <td style="padding: 12px; border: 1px solid #ccc; display: flex; justify-content: flex-end;">
                        <button class="btn-action" data-option="account" data-action="edit" data-id="${u.id}"
                                style="
                                padding: 8px 12px;
                                background-color: #4CAF50;
                                color: white;
                                border: none;
                                cursor: pointer;
                                border-radius: 5px;
                                margin-right: 10px ;
                                transition: 0.3s;
                                "
                                onmouseover="this.style.backgroundColor = '#388e3c'"
                                onmouseout="this.style.backgroundColor = '#4CAF50'">
                            Edit
                        </button>
                        <button class="btn-action" data-option="account" data-action="delete" data-id="${u.id}"
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
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>