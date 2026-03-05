 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Book - Library Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="assets/css/common.css">
</head>
<body>
 
 <%@ include file="includes/header.jsp" %>

<div class="container-fluid">
<div class="row">
     <%@ include file="includes/sidebar.jsp" %>
    <!-- Main content -->
    <main class="col-md-9 ms-sm-auto col-lg-10">
        <div class="page-header">
            <h1 class="h2"><i class="bi bi-book-fill me-2"></i>Add New Book</h1>
        </div>
		
		 <c:if test="${not empty errorMessage }">
		    <div class="alert alert-danger alert-dismissible fade show" role="alert">
		        <c:out value="${errorMessage}"/>
		        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		    </div>
		 </c:if>
		 
        <div class="form-container">
            <form id="addBookForm" action="BookController" method="post">
                <input type="hidden" name="action" value="addbook">
            
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="bookTitle" name="bookTitle" placeholder="Book Title">
                            <label for="bookTitle"><i class="bi bi-book me-2"></i>Book Title</label>
                            <div class="invalid-feedback">
                                Book title is required.
                              </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="author" name="author" placeholder="Author">
                            <label for="author"><i class="bi bi-person me-2"></i>Author</label>
                            <div class="invalid-feedback">
                                Author name is required.
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="isbn" name="isbn" placeholder="ISBN">
                            <label for="isbn"><i class="bi bi-hash me-2"></i>ISBN Number</label>
                       <div class="invalid-feedback">
        Valid ISBN number is required.
    </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select" id="category" name="category">
                                <option selected disabled value="">Select category</option>
                                <option value="fiction">Fiction</option>
                                <option value="non-fiction">Non-fiction</option>
                                <option value="science">Science</option>
                                <option value="technology">Technology</option>
                                <option value="history">History</option>
                                <option value="biography">Biography</option>
                                <option value="mystery">Mystery</option>
                                <option value="romance">Romance</option>
                            </select>
                            <label for="category"><i class="bi bi-collection me-2"></i>Category</label>
                         <div class="invalid-feedback">
        Please select a category.
    </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="publisher" name="publisher" placeholder="Publisher">
                            <label for="publisher"><i class="bi bi-building me-2"></i>Publisher</label>
                         <div class="invalid-feedback">
        Publisher name is required.
    </div>
                        </div>
                    </div>
                     
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="availableCopies" name="availableCopies" placeholder="Available Copies">
                            
                            <label for="pages"><i class="bi bi-file-text me-2"></i>Available Copies</label>
                         <div class="invalid-feedback">
        Available copies must be greater than 0.
    </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="number" class="form-control" id="numberOfcopies" name="numberOfcopies" placeholder="Copies" min="1" value="1">
                            <label for="copies"><i class="bi bi-stack me-2"></i>Number of Copies</label>
                       <div class="invalid-feedback">
        Number of copies must be at least 1.
    </div>
                        </div>
                    </div>
                </div>

                 

                <div class="form-actions">
                    <button type="submit" class="btn-modern">
                        <i class="bi bi-save"></i>Save Book
                    </button>
                </div>
            </form>
        </div>
    </main>
</div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
document.getElementById("addBookForm").addEventListener("submit", function (e) {

    let isValid = true;

    // Get fields
    const bookTitle = document.getElementById("bookTitle");
    const author = document.getElementById("author");
    const isbn = document.getElementById("isbn");
    const category = document.getElementById("category");
    const publisher = document.getElementById("publisher");
    const availableCopies = document.getElementById("availableCopies");
    const numberOfcopies = document.getElementById("numberOfcopies");

    // Reset validation
    document.querySelectorAll(".form-control, .form-select").forEach(el => {
        el.classList.remove("is-invalid");
    });

    // Required validation
    function checkRequired(field) {
        if (!field.value.trim()) {
            field.classList.add("is-invalid");
            isValid = false;
        }
    }

    checkRequired(bookTitle);
    checkRequired(author);
    checkRequired(isbn);
    checkRequired(publisher);
    checkRequired(availableCopies);
    checkRequired(numberOfcopies);

    // Category check
    if (!category.value) {
        category.classList.add("is-invalid");
        isValid = false;
    }

    // ISBN numeric validation
    if (isbn.value && !/^[0-9\-]+$/.test(isbn.value)) {
        isbn.classList.add("is-invalid");
        isValid = false;
    }

    // Copies > 0
    if (availableCopies.value <= 0) {
        availableCopies.classList.add("is-invalid");
        isValid = false;
    }

    if (numberOfcopies.value <= 0) {
        numberOfcopies.classList.add("is-invalid");
        isValid = false;
    }

    if (!isValid) {
        e.preventDefault();
    }

});
</script>
</body>
</html>
