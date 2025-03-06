<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
        <link rel="stylesheet" href="<%= request.getContextPath()%>/assets/css/style.css">


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
                <!-- Logo (Giữ nguyên hoặc chỉnh nếu muốn) -->
                <a class="navbar-brand fw-bold text-primary" href="${pageContext.request.contextPath}/">TechStore</a>

                <!-- Mobile Menu Toggle -->
                <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarContent">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- Navigation Links -->
                <div class="collapse navbar-collapse" id="navbarContent">
                    <ul class="navbar-nav mx-auto">
                        <li class="nav-item">
                            <a class="nav-link fw-bold" href="${pageContext.request.contextPath}/">Home</a>
                        </li>

                        <!-- Products Dropdown -->
                        <li class="nav-item dropdown">
                            <a class="nav-link fw-bold dropdown-toggle" href="#" id="productsDropdown" role="button" data-bs-toggle="dropdown">
                                Products
                            </a>
                            <ul class="dropdown-menu">
                                <li><h6 class="dropdown-header">Phones</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/apple">Apple</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/phones/samsung">Samsung</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><h6 class="dropdown-header">Laptops</h6></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/dell">Dell</a></li>
                                <li><a class="dropdown-item" href="${pageContext.request.contextPath}/category/laptops/hp">HP</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item fw-bold" href="${pageContext.request.contextPath}/products">View All Products</a></li>
                            </ul>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link fw-bold" href="${pageContext.request.contextPath}/deals">Deals</a>
                        </li>

                        <li class="nav-item">
                            <a class="nav-link fw-bold" href="${pageContext.request.contextPath}/contact">Contact</a>
                        </li>
                    </ul>
                    <form class="d-flex" action="${pageContext.request.contextPath}/search" method="GET">
                        <input class="form-control me-2" type="search" name="query" placeholder="Search..." aria-label="Search">
                        <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                    </form>
                    <!-- Right-side elements (Dịch sát phải) -->
                    <div class="d-flex align-items-center gap-3 ms-auto">
                        <!-- Wishlist -->
                        <c:if test="${user != null}">
                            <a href="${pageContext.request.contextPath}/wishlist" class="btn btn-outline-secondary border-0 d-none d-sm-inline-flex">
                                <i class="bi bi-heart"></i>
                            </a>
                        </c:if>

                        <!-- Shopping Cart -->
                        <c:if test="${user != null}">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline-secondary border-0 position-relative">
                                <i class="bi bi-cart"></i>
                                <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-primary">
                                    3
                                </span>
                            </a>
                        </c:if>
                        
                        <c:if test="${user == null}">
                            <a href="auth?action=login" class="btn border-0 d-flex align-items-center">
                                <i class="bi bi-box-arrow-in-right"></i>
                                <span style="margin-left: 5px;">
                                    Login
                                </span>
                            </a>
                            <a href="auth?action=register" class="btn border-0 d-flex align-items-center">
                                <i class="bi bi-person-add"></i>
                                <span style="margin-left: 5px;">
                                    Register
                                </span>
                            </a>
                        </c:if>

                        <c:if test="${user != null}">
                            <!-- User Account Dropdown -->
                            <div class="dropdown">
                                <button class="btn border-0 dropdown-toggle d-flex align-items-center" type="button" id="userDropdown" data-bs-toggle="dropdown">
                                    <i class="bi bi-person"></i>
                                </button>

                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><h6 class="dropdown-header">${user.fullName}</h6></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/account">Profile</a></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/orders">Orders</a></li>

                                    <!-- Kiểm tra role, nếu là admin thì hiển thị tab Management -->

                                    <c:if test="${user.role == 'admin'}">
                                        <li><hr class="dropdown-divider"></li>
                                        <li>
                                            <a class="dropdown-item fw-bold text-primary" href="${pageContext.request.contextPath}/Management">
                                                Management
                                            </a>
                                        </li>
                                    </c:if>


                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item text-danger fw-bold" href="auth?action=logout">Logout</a></li>
                                </ul>

                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </nav>