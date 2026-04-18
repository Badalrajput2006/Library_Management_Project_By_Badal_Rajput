<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Library Management</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Playfair+Display:wght@400;500;600&display=swap" rel="stylesheet">

    <style>
        /* --- MERGED COMMON & AUTH STYLES --- */
        :root {
            --primary-gradient: linear-gradient(135deg, #2C3E50 0%, #1ABC9C 100%);
            --auth-bg-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --auth-card-shadow: 0 20px 60px rgba(0,0,0,0.1);
            --auth-card-hover-shadow: 0 25px 80px rgba(0,0,0,0.15);
            --auth-border-radius: 20px;
            --auth-transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            --bg-gradient: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
        }

        body.auth-page {
            background: var(--auth-bg-gradient);
            margin: 0;
            padding: 2rem 1rem;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Inter', sans-serif;
            position: relative;
            overflow: hidden;
        }

        /* Animated Grid Effect from your Auth CSS */
        body.auth-page::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle, rgba(255,255,255,0.05) 1px, transparent 1px);
            background-size: 30px 30px;
            pointer-events: none;
            z-index: -1;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: var(--auth-border-radius);
            box-shadow: var(--auth-card-shadow);
            padding: 2.5rem;
            max-width: 420px;
            width: 100%;
            transition: var(--auth-transition);
            position: relative;
            z-index: 2;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--auth-card-hover-shadow);
        }

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .login-icon {
            width: 80px;
            height: 80px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            box-shadow: 0 10px 30px rgba(44, 62, 80, 0.3);
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }

        .login-icon i {
            font-size: 2.5rem;
            color: white;
        }

        .login-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 600;
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .login-subtitle {
            color: #6c757d;
            font-size: 0.95rem;
        }

        /* Form Controls from your Common CSS */
        .form-floating {
            margin-bottom: 1.5rem !important;  
        }

        .form-floating .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.8);
            transition: all 0.3s ease;
        }

        .form-floating .form-control:focus {
            border-color: #1ABC9C;
            box-shadow: 0 0 0 0.25rem rgba(26, 188, 156, 0.15);
            
        }

        .btn-login {
            background: var(--primary-gradient);
            border: none;
            border-radius: 12px;
            padding: 0.875rem 1.5rem;
            font-weight: 600;
            font-size: 1.1rem;
            color: white;
            width: 100%;
            box-shadow: 0 8px 25px rgba(44, 62, 80, 0.3);
            transition: var(--auth-transition);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 35px rgba(44, 62, 80, 0.4);
            color: white;
        }

        .text-danger.small {
            font-size: 0.8rem;
            margin-top: -1.2rem;
            margin-bottom: 0.8rem;
            display: block;
        }
    </style>
</head>
<body class="auth-page">

<div class="login-container">
    <div class="login-card">
        <div class="login-header">
            <div class="login-icon">
                <i class="bi bi-book-half"></i>
            </div>
            <h3 class="login-title">Badal's Library</h3>
            <p class="login-subtitle">Please sign in to your library account</p>
        </div>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert" style="border-radius: 12px;">
                <i class="bi bi-exclamation-circle-fill me-2"></i>
                <c:out value="${errorMessage}"/>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        
        <form action="Authentication" method="post">
            <input type="hidden" name="action" value="checkLogin">
            
            <div class="form-floating">
                <input type="text" class="form-control" id="username" name="username" placeholder="Username" autocomplete="off">
                <label for="username"><i class="bi bi-person-fill me-2"></i>Username</label>
            </div>
            <div class="text-danger small" id="usernameError"></div>

            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="password" placeholder="Password">
                <label for="password"><i class="bi bi-lock-fill me-2"></i>Password</label>
            </div>
            <div class="text-danger small" id="passwordError"></div>
           
            <button type="submit" class="btn btn-login">
                <i class="bi bi-box-arrow-in-right me-2"></i>Sign In
            </button>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script type="text/javascript">
    function setLoginValidation() {
        const form = document.querySelector('form');
        if(!form) return;

        form.addEventListener('submit', function(event) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            const usernameError = document.getElementById('usernameError');
            const passwordError = document.getElementById('passwordError');

            usernameError.textContent = '';
            passwordError.textContent = '';

            let hasError = false;
            if(!username) {
                usernameError.textContent = "Please enter username";
                hasError = true;
            }
            if(!password) {
                passwordError.textContent = "Please enter password";
                hasError = true;
            }
            if(hasError) {
                event.preventDefault();
            }
        });
    }
    document.addEventListener('DOMContentLoaded', setLoginValidation);
</script>

</body>
</html>