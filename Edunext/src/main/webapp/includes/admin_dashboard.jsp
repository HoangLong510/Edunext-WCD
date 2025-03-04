<jsp:include page="../includes/header.jsp"/>

<!-- Layout -->
<div class="d-flex flex-column flex-lg-row" style="
     justify-content: flex-start;
     align-items: stretch;
     width: 100%;
     gap: 20px;
     padding: 20px;">

    <!-- Sidebar -->
    <div class="col-lg-3 col-12" style="
         display: flex;
         flex-direction: column;
         align-items: center;
         background-color: #fff;
         border-radius: 10px;
         padding: 20px;
         gap: 10px;
         min-height: 500px;
         box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
         ">
        <a id="generalTab" href="#" class="btn sidebar-btn btn-light" style="width: 100%; text-align: center;">General</a>
        <a id="accountTab" href="#" class="btn sidebar-btn btn-light" style="width: 100%; text-align: center;">Account</a>
        <a id="productTab" href="#" class="btn sidebar-btn btn-light" style="width: 100%; text-align: center;">Product</a>
        <a id="categoryTab" href="#" class="btn sidebar-btn btn-light" style="width: 100%; text-align: center;">Category</a>
        <a id="brandTab" href="#" class="btn sidebar-btn btn-light" style="width: 100%; text-align: center;">Brand</a>
    </div>

    <!-- Content -->
    <div id="content-panel" class="col-lg-9 col-12" style="
         display: flex;
         flex-direction: column;
         align-items: flex-start;
         background-color: #fff;
         border-radius: 10px;
         padding: 20px;
         box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);
         ">
        <jsp:include page="${contentPage}" flush="true"/>
    </div>
</div>

</div>

<jsp:include page="../includes/footer.jsp"/>
