<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tech Store - Phones & Laptops</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

        <script>
            $(document).ready(function () {
                $(".menu-item").click(function () {
                    var option = $(this).attr("data-option");
                    $.get("Management/", {option: option, action: "list"}, function (response) {
                        $("#panel-content").html(response);
                    });
                });

                $(document).on("click", ".btn-action", function () {
                    var option = $(this).data("option");
                    var action = $(this).data("action");
                    var id = $(this).data("id") || "";

                    $.get("Management/", {option: option, action: action, id: id}, function (response) {
                        $("#panel-content").html(response);
                    });
                });
            });
        </script>
    </head>
    <body>

        <!-- Top Info Bar -->
        <div class="d-none d-lg-block bg-light">
            <div class="container py-2">
                <div class="row align-items-center">
                    <div class="col-auto">
                        <div class="d-flex align-items-center gap-3 text-secondary small">
                            <div>
                                <i class="bi bi-headset me-1"></i>
                                <span>Support: (800) 123-4567</span>
                            </div>
                        </div>
                    </div>
                    <div class="col-auto ms-auto">
                        <div class="d-flex gap-3 small">
                            <a href="${pageContext.request.contextPath}/track-order" class="text-secondary text-decoration-none hover-primary">Track Order</a>
                            <a href="${pageContext.request.contextPath}/support" class="text-secondary text-decoration-none hover-primary">Support</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Main Navbar -->
        <nav class="navbar navbar-expand-lg navbar-light bg-white sticky-top shadow-sm">
            <div class="container py-2">
                <!-- Logo -->
                <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">TechStore</a>

                <!-- Mobile Toggle Button -->
                <div class="d-flex align-items-center gap-2 order-lg-last">
                    <!-- Search Toggle (Mobile) -->
                    <button class="btn btn-sm btn-outline-secondary border-0 d-lg-none" type="button" id="searchToggle">
                        <i class="bi bi-search"></i>
                    </button>

                    <!-- Wishlist -->
                    <a href="${pageContext.request.contextPath}/wishlist" class="btn btn-sm btn-outline-secondary border-0 d-none d-sm-inline-flex">
                        <i class="bi bi-heart"></i>
                    </a>

                    <!-- User Account Dropdown -->
                    <div class="dropdown">
                        <button class="btn btn-sm btn-outline-secondary border-0 dropdown-toggle" type="button" id="userDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="bi bi-person"></i>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                            <li><h6 class="dropdown-header">My Account</h6></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account">Profile</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">Orders</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/wishlist">Wishlist</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/login">Login</a></li>
                            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/register">Register</a></li>
                        </ul>
                    </div>

                    <!-- Shopping Cart -->
                    <a href="${pageContext.request.contextPath}/cart" class="btn btn-sm btn-outline-secondary border-0 position-relative">
                        <i class="bi bi-cart"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary">
                            3
                            <span class="visually-hidden">items in cart</span>
                        </span>
                    </a>

                    <!-- Mobile Menu Toggle -->
                    <button class="navbar-toggler border-0 ms-2" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                </div>

                <!-- Desktop Search Bar -->
                <form class="d-none d-lg-flex mx-auto" style="width: 35%;">
                    <div class="input-group">
                        <input type="search" class="form-control" placeholder="Search products..." aria-label="Search">
                        <button class="btn btn-outline-secondary" type="submit">
                            <i class="bi bi-search"></i>
                        </button>
                    </div>
                </form>

                <!-- Mobile Search Bar (Initially Hidden) -->
                <div class="collapse w-100 mt-2 d-lg-none" id="searchCollapse">
                    <form class="d-flex">
                        <div class="input-group">
                            <input type="search" class="form-control" placeholder="Search products..." aria-label="Search">
                            <button class="btn btn-outline-secondary" type="submit">
                                <i class="bi bi-search"></i>
                            </button>
                        </div>
                    </form>
                </div>

                <!-- Navigation Links -->
                <div class="collapse navbar-collapse mt-3 mt-lg-0" id="navbarContent">
                    <ul class="navbar-nav">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <!-- Phones Dropdown -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="phonesDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Phones
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="phonesDropdown">
                                <li><h6 class="dropdown-header">Brands</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/apple">Apple</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/samsung">Samsung</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/google">Google</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/xiaomi">Xiaomi</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones">View All Phones</a></li>
                            </ul>
                        </li>

                        <!-- Laptops Dropdown -->
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" id="laptopsDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                Laptops
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="laptopsDropdown">
                                <li><h6 class="dropdown-header">Brands</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/apple">Apple</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/dell">Dell</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/hp">HP</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/lenovo">Lenovo</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops">View All Laptops</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/accessories">Accessories</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/deals">Deals</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>               
        <!-- Sidebar -->
        <div class="d-flex" style="height: 100vh;">
            <div style="
                 width: 220px;
                 background: #2c3e50;
                 color: white;
                 padding: 20px 10px;
                 display: flex;
                 flex-direction: column;
                 gap: 10px;
                 ">
                <button class="btn-action" 
                        data-option="account"
                        style="display: block;
                        width: 100%;
                        padding: 12px;
                        color: white;
                        background: none;
                        border: none;
                        text-align: left;
                        cursor: pointer;
                        transition: background 0.3s;">
                    Account
                </button>
                <button class="btn-action" 
                        data-option="brand"
                        style="display: block;
                        width: 100%;
                        padding: 12px;
                        color: white;
                        background: none;
                        border: none;
                        text-align: left;
                        cursor: pointer;
                        transition: background 0.3s;">
                    Brand
                </button>
                <button class="btn-action" 
                        data-option="category"
                        style="display: block;
                        width: 100%;
                        padding: 12px;
                        color: white;
                        background: none;
                        border: none;
                        text-align: left;
                        cursor: pointer;
                        transition: background 0.3s;">
                    Category
                </button>
                <button class="btn-action" 
                        data-option="product"
                        style="display: block;
                        width: 100%;
                        padding: 12px;
                        color: white;
                        background: none;
                        border: none;
                        text-align: left;
                        cursor: pointer;
                        transition: background 0.3s;">
                    Product
                </button>
            </div>

            <!-- Panel -->
            <div style="
                 flex: 1;
                 padding: 10px;
                 background: #f8f9fa;
                 display: flex;
                 justify-content: center;
                 align-items: center;
                 min-height: 80vh;
                 ">
                <div id="panel-content" style="
                     width: 95%;
                     min-height: 800px;
                     background: white;
                     padding: 20px;
                     border-radius: 8px;
                     box-shadow: 0 4px 8px rgba(0,0,0,0.1);
                     ">
                    <h4 style="text-align: center; color: #555;">Welcome to Tech Store Management</h4>
                    <p style="text-align: center; color: #777;">Select an option from the sidebar to manage data.</p>
                </div>
            </div>
        </div> 
        <script>
            document.querySelectorAll(".btn-action").forEach(button => {
                button.addEventListener("mouseenter", function () {
                    this.style.background = "#1a252f";
                });

                button.addEventListener("mouseleave", function () {
                    this.style.background = "none";
                });
            });
        </script>

        <script>
            // Sidebar
            document.querySelectorAll(".menu-item").forEach(button => {
                button.addEventListener("click", function () {
                    let option = this.getAttribute("data-option");
                    loadPanel(option);

                });
            });

            //  Add, Edit, Delete
            document.addEventListener("click", function (event) {
                if (event.target.classList.contains("btn-action")) {
                    let option = event.target.getAttribute("data-option");
                    let action = event.target.getAttribute("data-action") || "list";
                    let id = event.target.getAttribute("data-id") || "";
                    loadPanel(option, action, id);
                }
            });
            // Call Servlet with action( default = list) 
            function loadPanel(option, action = "list", id) {
                let url = `/Edunext/Management/` + option + `?action=` + action;
                if (id)
                    url += "&id=" + id;
                fetch(url)
                        .then(response => response.text())
                        .then(html => {
                            document.getElementById("panel-content").innerHTML = html;
                        })
                        .catch(error => console.error("Error:", error));
            }

        </script>
    </body>
    <!-- Footer -->
    <footer class="pt-5 pb-4 border-top">
        <div class="container">
            <div class="row g-4 text-center text-md-start">
                <!-- Column 1 -->
                <div class="col-lg-3 col-md-6">
                    <h5 class="fw-bold mb-3">Tech Store</h5>
                    <p class="text-muted">Your one-stop shop for the latest smartphones, laptops, and tech accessories.</p>
                    <div class="d-flex justify-content-center justify-content-md-start">
                        <a href="#" class="social-icon mx-2"><i class="bi bi-facebook"></i></a>
                        <a href="#" class="social-icon mx-2"><i class="bi bi-instagram"></i></a>
                        <a href="#" class="social-icon mx-2"><i class="bi bi-twitter-x"></i></a>
                        <a href="#" class="social-icon mx-2"><i class="bi bi-youtube"></i></a>
                    </div>
                </div>

                <!-- Column 2 -->
                <div class="col-lg-3 col-md-6">
                    <h5 class="fw-bold mb-3">Quick Links</h5>
                    <ul class="list-unstyled">
                        <li class="mb-2"><a href="#" class="text-decoration-none text-muted">About Us</a></li>
                        <li class="mb-2"><a href="#" class="text-decoration-none text-muted">Contact Us</a></li>
                        <li class="mb-2"><a href="#" class="text-decoration-none text-muted">Blog</a></li>
                        <li class="mb-2"><a href="#" class="text-decoration-none text-muted">FAQs</a></li>
                        <li class="mb-2"><a href="#" class="text-decoration-none text-muted">Shipping & Returns</a></li>
                    </ul>
                </div>

                <!-- Column 3 -->
                <div class="col-lg-3 col-md-6">
                    <h5 class="fw-bold mb-3">Contact</h5>
                    <ul class="list-unstyled">
                        <li class="mb-3 d-flex align-items-center justify-content-center justify-content-md-start">
                            <i class="bi bi-geo-alt text-primary me-2"></i>
                            <span class="text-muted">123 Tech Street, Digital City, 10001</span>
                        </li>
                        <li class="mb-3 d-flex align-items-center justify-content-center justify-content-md-start">
                            <i class="bi bi-telephone text-primary me-2"></i>
                            <span class="text-muted">+1 (555) 123-4567</span>
                        </li>
                        <li class="mb-3 d-flex align-items-center justify-content-center justify-content-md-start">
                            <i class="bi bi-envelope text-primary me-2"></i>
                            <span class="text-muted">support@tech_store.com</span>
                        </li>
                    </ul>
                </div>

                <!-- Column 4 -->
                <div class="col-lg-3 col-md-6">
                    <h5 class="fw-bold mb-3">Newsletter</h5>
                    <p class="text-muted">Subscribe to our newsletter for the latest products and exclusive offers.</p>
                    <form>
                        <div class="mb-2">
                            <input type="email" class="form-control" placeholder="Your email address">
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Subscribe</button>
                    </form>
                </div>
            </div>

            <div class="border-top mt-4 pt-4 text-center text-muted">
                <p class="small mb-0">© <script>document.write(new Date().getFullYear())</script> Tech Store. All rights reserved.</p>
            </div>
        </div>
    </footer>


</html>
