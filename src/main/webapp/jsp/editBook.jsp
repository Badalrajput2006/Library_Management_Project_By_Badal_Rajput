<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update Book - Library Management</title>

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

<main class="col-md-9 ms-sm-auto col-lg-10">

<div class="page-header">
<h1 class="h2"><i class="bi bi-book-fill me-2"></i>Update Book</h1>
</div>

<c:if test="${not empty successMessage}">
<div class="alert alert-success alert-dismissible fade show" role="alert">
<c:out value="${successMessage}"/>
<button type="button" class="btn-close" data-bs-dismiss="alert"></button>
</div>
</c:if>

<div class="form-container">

<form id="updateBookForm" action="BookController" method="post" novalidate>

<input type="hidden" name="action" value="updateBook">
<input type="hidden" name="bookId" value="${book.bookId}">

<div class="row">
<div class="col-md-6">
<div class="form-floating">
<input type="text" class="form-control" id="bookTitle" name="bookTitle"
placeholder="Book Title" value="${book.title}" required>
<label for="bookTitle"><i class="bi bi-book me-2"></i>Book Title</label>
<div class="invalid-feedback">Title must be 3–100 characters.</div>
</div>
</div>

<div class="col-md-6">
<div class="form-floating">
<input type="text" class="form-control" id="author" name="author"
placeholder="Author" value="${book.author}" required>
<label for="author"><i class="bi bi-person me-2"></i>Author</label>
<div class="invalid-feedback">Author must contain only letters (3–50 characters).</div>
</div>
</div>
</div>

<div class="row mt-3">
<div class="col-md-6">
<div class="form-floating">
<input type="text" class="form-control" id="isbn" name="isbn"
placeholder="ISBN" value="${book.isbn}" required>
<label for="isbn"><i class="bi bi-hash me-2"></i>ISBN Number</label>
<div class="invalid-feedback">ISBN must be 10 or 13 digits.</div>
</div>
</div>

<div class="col-md-6">
<div class="form-floating">
<select class="form-select" id="category" name="category" required>
<option value="">Select category</option>
<option value="fiction" ${book.category == 'fiction' ? 'selected' : ''}>Fiction</option>
<option value="non-fiction" ${book.category == 'non-fiction' ? 'selected' : ''}>Non-fiction</option>
<option value="science" ${book.category == 'science' ? 'selected' : ''}>Science</option>
<option value="technology" ${book.category == 'technology' ? 'selected' : ''}>Technology</option>
<option value="history" ${book.category == 'history' ? 'selected' : ''}>History</option>
<option value="biography" ${book.category == 'biography' ? 'selected' : ''}>Biography</option>
<option value="mystery" ${book.category == 'mystery' ? 'selected' : ''}>Mystery</option>
<option value="romance" ${book.category == 'romance' ? 'selected' : ''}>Romance</option>
</select>
<label for="category"><i class="bi bi-collection me-2"></i>Category</label>
<div class="invalid-feedback">Please select a category.</div>
</div>
</div>
</div>

<div class="row mt-3">
<div class="col-md-6">
<div class="form-floating">
<input type="text" class="form-control" id="publisher" name="publisher"
placeholder="Publisher" value="${book.publisher}" required>
<label for="publisher"><i class="bi bi-building me-2"></i>Publisher</label>
<div class="invalid-feedback">Publisher must be at least 2 characters.</div>
</div>
</div>

<div class="col-md-6">
<div class="form-floating">
<input type="number" class="form-control" id="numberOfcopies" name="numberOfcopies"
placeholder="Copies" min="1" value="${book.totalCopies}" required>
<label for="numberOfcopies"><i class="bi bi-stack me-2"></i>Number of Copies</label>
<div class="invalid-feedback">Copies must be at least 1.</div>
</div>
</div>
</div>

<div class="form-actions mt-4">
<button type="submit" class="btn-modern">
<i class="bi bi-save"></i> Update Book
</button>
</div>

</form>
</div>
</main>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
(function () {

const form = document.getElementById('updateBookForm');

form.addEventListener('submit', function (event) {

let isValid = true;

const title = document.getElementById("bookTitle");
const author = document.getElementById("author");
const isbn = document.getElementById("isbn");
const category = document.getElementById("category");
const publisher = document.getElementById("publisher");
const copies = document.getElementById("numberOfcopies");

// Title validation
if (title.value.trim().length < 3) {
title.setCustomValidity("Invalid");
isValid = false;
} else {
title.setCustomValidity("");
}

// Author validation
const authorRegex = /^[A-Za-z\s]{3,50}$/;
if (!authorRegex.test(author.value.trim())) {
author.setCustomValidity("Invalid");
isValid = false;
} else {
author.setCustomValidity("");
}

// ISBN validation
const isbnRegex = /^\d{10}(\d{3})?$/;
if (!isbnRegex.test(isbn.value.trim())) {
isbn.setCustomValidity("Invalid");
isValid = false;
} else {
isbn.setCustomValidity("");
}

// Category validation
if (category.value === "") {
category.setCustomValidity("Invalid");
isValid = false;
} else {
category.setCustomValidity("");
}

// Publisher validation
if (publisher.value.trim().length < 2) {
publisher.setCustomValidity("Invalid");
isValid = false;
} else {
publisher.setCustomValidity("");
}

// Copies validation
if (copies.value < 1 || copies.value === "") {
copies.setCustomValidity("Invalid");
isValid = false;
} else {
copies.setCustomValidity("");
}

if (!isValid) {
event.preventDefault();
event.stopPropagation();
alert("⚠ Please fill all required fields correctly.");
}

form.classList.add('was-validated');

}, false);

})();
</script>

</body>
</html>
