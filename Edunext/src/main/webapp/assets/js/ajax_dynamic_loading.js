document.addEventListener("DOMContentLoaded", function () {
    let currentPath = window.location.pathname;
    document.querySelectorAll(".menu-item").forEach((item) => {
        let itemPath = item.getAttribute("href");
        if (itemPath && currentPath.includes(itemPath.replace(/^\//, ""))) {
            item.classList.add("active");
        }
    });
});

function loadContent(page) {
    console.log('Loading content for page:', page);
    fetch('Management/' + page)
        .then(response => {
            console.log('Response status:', response.status);
            if (!response.ok)
                throw new Error("Server responded with status " + response.status);
            return response.text();
        })
        .then(data => {
            let contentPanel = document.getElementById('content-panel');
            if (contentPanel) {
                contentPanel.innerHTML = data;
                attachEventListeners(page);
            }
        })
        .catch(error => console.error('Error:', error));
}

function attachEventListeners(page) {
    if (page.includes('category')) {
        let addCategoryLink = document.getElementById('addCategoryLink');
        if (addCategoryLink) {
            addCategoryLink.addEventListener('click', function (event) {
                event.preventDefault();
                loadContent('category&pageAction=add');
            });
        }

        let submitCategory = document.getElementById('submitCategory');
        if (submitCategory) {
            submitCategory.addEventListener('click', function (event) {
                event.preventDefault();
                submitForm('category');
            });
        }
    } else if (page.includes('product')) {
        let addProductLink = document.getElementById('addProductLink');
        if (addProductLink) {
            addProductLink.addEventListener('click', function (event) {
                event.preventDefault();
                loadContent('product&pageAction=add');
            });
        }

        let submitProduct = document.getElementById('submitProduct');
        if (submitProduct) {
            submitProduct.addEventListener('click', function (event) {
                event.preventDefault();
                submitForm('product');
            });
        }
    } else if (page.includes('brand')) {
        let addBrandLink = document.getElementById('addBrandLink');
        if (addBrandLink) {
            addBrandLink.addEventListener('click', function (event) {
                event.preventDefault();
                loadContent('brand&pageAction=add');
            });
        }

        let submitBrand = document.getElementById('submitBrand');
        if (submitBrand) {
            submitBrand.addEventListener('click', function (event) {
                event.preventDefault();
                submitForm('brand');
            });
        }
    }
}

function submitForm(page) {
    let form = document.getElementById(page + "Form");
    if (!form) {
        console.error("Form not found:", page + "Form");
        return;
    }

    let formData = new FormData(form);

    fetch("Management?page=" + page + "&pageAction=add", {
        method: "POST",
        body: formData,
        headers: {
            "X-Requested-With": "XMLHttpRequest"
        }
    })
    .then(response => response.json())  
    .then(data => {
        console.log("Response from server:", data);
        if (data.success) {
            alert(data.message);
            history.pushState(null, "", "Management#" + page);
            setTimeout(() => loadContent(page), 500); // Chờ 500ms trước khi load lại
        } else {
            alert("Error: " + (data.message || "Could not add " + page));
        }
    })
    .catch(error => console.error("Fetch error:", error)); 
}



document.querySelectorAll(".sidebar-btn").forEach(tab => {
    tab.addEventListener("click", function (event) {
        event.preventDefault();
        let page = this.id.replace("Tab", "").toLowerCase();
        loadContent(page);
    });
});
