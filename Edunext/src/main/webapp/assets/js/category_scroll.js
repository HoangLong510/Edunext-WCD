document.addEventListener("DOMContentLoaded", async function () {

    try {
        // Fetch dữ liệu từ categories.json
        const response = await fetch("/Edunext/assets/js/categories.json");
        const categories = await response.json();

        // Kiểm tra dữ liệu
        console.log("Categories loaded:", categories);

        const swiperWrapper = document.querySelector(".swiper-wrapper");

        if (!swiperWrapper) {
            console.error("Không tìm thấy .swiper-wrapper!");
            return;
        }

        // Xóa nội dung cũ (nếu có)
        swiperWrapper.innerHTML = "";

        // Render danh mục từ JSON
        categories.forEach(category => {
            const slide = document.createElement("div");
            slide.classList.add("swiper-slide", "text-center");

            slide.innerHTML = `
                <i class="${category.icon} fs-3 text-primary"></i>
                <h6>${category.name}</h6>
            `;

            swiperWrapper.appendChild(slide);
        });

        // Khởi tạo Swiper
        const swiper = new Swiper(".swiper-container", {
            slidesPerView: 4,
            spaceBetween: 20,
            loop: true,
            navigation: {
                nextEl: ".swiper-button-next",
                prevEl: ".swiper-button-prev"
            },
            grabCursor: true,
            breakpoints: {
                768: {slidesPerView: 3},
                576: {slidesPerView: 2},
                320: {slidesPerView: 1}
            }
        });

        console.log("Swiper initialized successfully!");
    } catch (error) {
        console.error("Lỗi khi tải categories.json:", error);
    }
});
