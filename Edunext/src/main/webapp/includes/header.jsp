<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TechStore - Phones & Laptops</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Bootstrap Icons -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css" />
         <!-- Custom CSS -->
        <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css/style.css">


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


