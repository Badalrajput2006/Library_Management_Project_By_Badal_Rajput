<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="includes/header.jsp" %>

<div class="container-fluid">
<div class="row">

    <!-- Sidebar -->
    <%@ include file="includes/sidebar.jsp" %>

    <!-- Main content -->
    <main class="col-md-9 ms-sm-auto col-lg-10">
        <div class="page-header">
            <h1 class="h2">
                <i class="bi bi-arrow-right-circle me-2"></i>
                Assign Book to Member
            </h1>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show">
                <c:out value="${successMessage}" />
                <button type="button" class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show">
                <c:out value="${errorMessage}" />
                <button type="button" class="btn-close"
                        data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="form-container">
            <form id="assignForm" action="BookController" method="post" novalidate>
                <input type="hidden" name="action" value="assignBook">

                <div class="row">

                    <!-- Select Book -->
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select"
                                    id="bookId"
                                    name="bookId" required>

                                <option value="" selected disabled>
                                    
                                </option>

                                <c:forEach var="book" items="${bookList}">
                                    <option value="${book.bookId}">
                                       <c:out value="${book.title}"/> - <c:out value="${book.author}"/> (Available - <c:out value="${book.availableCopies}" /> )
                                    </option>
                                </c:forEach>

                            </select>
                            
                            <label for="bookId" style="color:black">
                                <i class="bi bi-book-fill me-2"></i>
                                Select Book
                            </label>
                           
                            <div class="invalid-feedback">
        Please select a book.
    </div>
                        </div>
                    </div>

                    <!-- Select Member -->
                    <div class="col-md-6">
                        <div class="form-floating">
                            <select class="form-select"
                                    id="userId"
                                    name="userId"
                                    required>

                                <option value="" selected disabled> 
                                </option>

                                <c:forEach var="user" items="${userList}">
                                    <option value="${user.userId}">
                                       <c:out value="${user.firstName}"/>  <c:out value="${user.lastName}"/> - <c:out value="${user.email}"/>
                                    </option>
                                </c:forEach>

                            </select>
                            <label for="userId" style="color:black">
                                <i class="bi bi-person-fill me-2"></i>
                                Select Member
                            </label>
                             <div class="invalid-feedback">
        Please select a member.
    </div>
                        </div>
                    </div>

                </div>

                <!-- Due Date -->
                <div class="col-md-6 mt-3">
                    <div class="form-floating">
                        <input type="date"
                               class="form-control"
                               id="dueDate"
                               name="dueDate"
                               required>
                        <label for="dueDate">
                            <i class="bi bi-calendar-event me-2"></i>
                            Due Date
                        </label>
                        <div class="invalid-feedback">
        Please select a due date.
    </div>
                    </div>
                </div>

                <!-- Notes -->
                <div class="form-floating mt-3">
                    <textarea class="form-control"
                              id="assignmentNotes"
                              name="assignmentNotes"
                              placeholder="Notes"
                               style="height: 100px"></textarea>

                    <label for="assignmentNotes">
                        <i class="bi bi-card-text me-2"></i>
                        Assignment Notes (Optional)
                    </label>
                </div>

                <!-- Submit Button -->
                <div class="form-actions mt-3">
                    <button type="submit" class="btn-modern">
                        <i class="bi bi-check-circle"></i>
                        Assign Book
                    </button>
                </div>

            </form>
        </div>

    </main>
</div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
(() => {
    'use strict'

    const form = document.getElementById('assignForm');

    form.addEventListener('submit', function (event) {

        if (!form.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }

        form.classList.add('was-validated');

    }, false);
})();
</script>
</body>
</html>
