<!-- JavaScript -->
<script src="/Edunext/assets/js/category_scroll.js" defer></script>
<script src="/Edunext/assets/js/ajax_dynamic_loading.js" defer></script>
<!-- Bootstrap & Swiper Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>

<script>
    // Toggle search bar on mobile
    document.addEventListener('DOMContentLoaded', function () {
        const searchToggle = document.getElementById('searchToggle');
        const searchCollapse = document.getElementById('searchCollapse');

        if (searchToggle && searchCollapse) {
            searchToggle.addEventListener('click', function () {
                const bsCollapse = new bootstrap.Collapse(searchCollapse);
                bsCollapse.toggle();
            });
        }
    });
    document.addEventListener("click", function (event) {
        let offcanvas = document.getElementById("navbarOffcanvas");
        let offcanvasInstance = bootstrap.Offcanvas.getInstance(offcanvas);

        if (offcanvasInstance && !offcanvas.contains(event.target) && !event.target.closest(".navbar-toggler")) {
            offcanvasInstance.hide();
        }
    });
    
</script>
</body>

<!-- Footer -->
<footer class="pt-5 pb-4 border-top">
    <div class="container">
        <div class="row g-4 text-center text-md-start">
            <!-- Column 1 -->
            <div class="col-lg-3 col-md-6">
                <h5 class="fw-bold mb-3">TechStore</h5>
                <p class="text-muted">Your one-stop shop for the latest smartphones, laptops, and tech accessories.</p>
                <div class="d-flex justify-content-center justify-content-md-start">
                    <a href="#" class="social-icon mx-2">
                        <i class="bi bi-facebook"></i>
                    </a>
                    <a href="#" class="social-icon mx-2">
                        <i class="bi bi-instagram"></i>
                    </a>
                    <a href="#" class="social-icon mx-2">
                        <i class="bi bi-twitter-x"></i>
                    </a>
                    <a href="#" class="social-icon mx-2">
                        <i class="bi bi-youtube"></i>
                    </a>
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
                        <span class="text-muted">support@techstore.com</span>
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
            <p class="small mb-0">© <script>document.write(new Date().getFullYear())</script> TechStore. All rights reserved.</p>
        </div>
    </div>
</footer>

</html>



