<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/includes/header.jsp"/>


    <!-- Hero Section -->
    <section class="hero-section mt-5 pt-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 mb-5 mb-lg-0 order-lg-1">
                    <h1 class="display-4 fw-bold mb-3">Latest Tech at <span class="text-primary">Unbeatable Prices</span></h1>
                    <p class="lead mb-4">Discover the newest smartphones and laptops with exclusive deals and free shipping.</p>
                    <div class="d-grid gap-2 d-sm-flex">
                        <button class="btn btn-primary btn-lg px-4">Find Your Device</button>
                        <button class="btn btn-outline-primary btn-lg px-4">Explore Laptops</button>
                    </div>
                </div>
                <div class="col-lg-6 text-center order-lg-2">
                    <!-- Bootstrap Carousel -->
                    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel" data-bs-interval="3000">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img src="https://placehold.co/600x400" alt="Smartphone Deals" class="img-fluid rounded">
                            </div>
                            <div class="carousel-item">
                                <img src="https://placehold.co/600x400?text=Laptop+Sale" alt="Laptop Sale" class="img-fluid rounded">
                            </div>
                            <div class="carousel-item">
                                <img src="https://placehold.co/600x400?text=New+Tech" alt="New Tech Arrivals" class="img-fluid rounded">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories -->
    <section class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Shop by Category</h2>
            <div class="swiper-container">
                <div class="swiper-wrapper">
                </div>

            </div>
        </div>
    </section>
    <!-- Featured Products Section -->
    <section class="py-5 bg-light">
        <div class="container">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2>Featured Products</h2>
                <a href="#" class="text-decoration-none text-primary">View all</a>
            </div>

            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
                <!-- Product 1 -->
                <div class="col">
                    <div class="card h-100 product-card">
                        <span class="badge bg-primary badge-corner">New</span>
                        <div class="product-img-container">
                            <img src="https://placehold.co/300x300" class="product-img" alt="iPhone 15 Pro">
                        </div>
                        <div class="card-body">
                            <p class="text-muted text-uppercase small">smartphone</p>
                            <h5 class="card-title">iPhone 15 Pro</h5>
                            <div class="mb-2">
                                <span class="rating-stars">
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-half filled"></i>
                                    <span class="ms-1 text-muted">4.8</span>
                                </span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <h5 class="fw-bold mb-0">$999</h5>
                                <span class="text-muted text-decoration-line-through ms-2">$1099</span>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <button class="btn btn-primary w-100">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 2 -->
                <div class="col">
                    <div class="card h-100 product-card">
                        <span class="badge bg-success badge-corner">Top Rated</span>
                        <div class="product-img-container">
                            <img src="https://placehold.co/300x300" class="product-img" alt="Samsung Galaxy S24 Ultra">
                        </div>
                        <div class="card-body">
                            <p class="text-muted text-uppercase small">smartphone</p>
                            <h5 class="card-title">Samsung Galaxy S24 Ultra</h5>
                            <div class="mb-2">
                                <span class="rating-stars">
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-half filled"></i>
                                    <span class="ms-1 text-muted">4.7</span>
                                </span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <h5 class="fw-bold mb-0">$1199</h5>
                                <span class="text-muted text-decoration-line-through ms-2">$1299</span>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <button class="btn btn-primary w-100">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 3 -->
                <div class="col">
                    <div class="card h-100 product-card">
                        <span class="badge bg-danger badge-corner">Sale</span>
                        <div class="product-img-container">
                            <img src="https://placehold.co/300x300" class="product-img" alt="MacBook Pro 14">
                        </div>
                        <div class="card-body">
                            <p class="text-muted text-uppercase small">laptop</p>
                            <h5 class="card-title">MacBook Pro 14"</h5>
                            <div class="mb-2">
                                <span class="rating-stars">
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <span class="ms-1 text-muted">4.9</span>
                                </span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <h5 class="fw-bold mb-0">$1599</h5>
                                <span class="text-muted text-decoration-line-through ms-2">$1799</span>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <button class="btn btn-primary w-100">Add to Cart</button>
                        </div>
                    </div>
                </div>

                <!-- Product 4 -->
                <div class="col">
                    <div class="card h-100 product-card">
                        <div class="product-img-container">
                            <img src="https://placehold.co/300x300" class="product-img" alt="Dell XPS 15">
                        </div>
                        <div class="card-body">
                            <p class="text-muted text-uppercase small">laptop</p>
                            <h5 class="card-title">Dell XPS 15</h5>
                            <div class="mb-2">
                                <span class="rating-stars">
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-fill filled"></i>
                                    <i class="bi bi-star-half filled"></i>
                                    <span class="ms-1 text-muted">4.6</span>
                                </span>
                            </div>
                            <div class="d-flex align-items-center mb-3">
                                <h5 class="fw-bold mb-0">$1399</h5>
                                <span class="text-muted text-decoration-line-through ms-2">$1499</span>
                            </div>
                        </div>
                        <div class="card-footer bg-white border-top-0">
                            <button class="btn btn-primary w-100">Add to Cart</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>



<jsp:include page="/includes/footer.jsp"/>
