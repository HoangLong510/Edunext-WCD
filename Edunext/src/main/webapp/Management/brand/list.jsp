<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div style="min-height: 100%;
     width: 100%;
     margin: 0 auto;
     padding: 20px;
     background-color: white
     ; border-radius: 10px;
     box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);">
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h2 style="text-align: center;">Brand List</h2>
        <a id="addBrandLink" class="btn btn-primary" href="#" style="
            display: inline-block;
            padding: 8px 15px;
            font-size: 16px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            ">Create a new Brand</a>
    </div>
    <div style="overflow-x: auto;">
        <table style="
            width: 100%;
            border-collapse: collapse;
            min-width: 600px;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            ">
            <thead>
                <tr style="background-color: #f0f0f0; text-align: left;">
                    <th style="padding: 12px 15px; font-weight: bold; border-bottom: 2px solid #ddd;">Id</th>
                    <th style="padding: 12px 15px; font-weight: bold; border-bottom: 2px solid #ddd;">Logo</th>
                    <th style="padding: 12px 15px; font-weight: bold; border-bottom: 2px solid #ddd;">Name</th>
                    <th style="padding: 12px 15px; font-weight: bold; border-bottom: 2px solid #ddd;">Description</th>
                    <th style="padding: 12px 15px; font-weight: bold; border-bottom: 2px solid #ddd; text-align: center;">Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="b" items="${brands}">
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 12px 15px;">${b.id}</td>
                        <td style="padding: 12px 15px; text-align: center;">
                            <img src="${b.logo}" alt="Brand Logo" style="width: 50px; height: auto; border-radius: 5px; vertical-align: middle;">
                        </td>
                        <td style="padding: 12px 15px;">${b.name}</td>
                        <td style="padding: 12px 15px;">${b.description}</td>
                        <td style="padding: 12px 15px; text-align: center;">
                            <a class="editBrandLink btn btn-warning" href="#" data-id="${b.id}" style="
                                display: inline-block;
                                padding: 8px 12px;
                                font-size: 14px;
                                text-decoration: none;
                                color: white;
                                background-color: #ffc107;
                                border-radius: 5px;
                                ">Edit</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.getElementById('addBrandLink').addEventListener('click', function(event) {
            event.preventDefault();
            loadContent('brand&pageAction=add');
        });

        document.querySelectorAll('.editBrandLink').forEach(link => {
            link.addEventListener('click', function(event) {
                event.preventDefault();
                const brandId = this.getAttribute('data-id');
                loadContent('brand&pageAction=edit&id=' + brandId);
            });
        });
    });
</script>