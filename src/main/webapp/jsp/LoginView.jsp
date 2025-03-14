<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login - Turf Booking</title>
<style>
    :root {
        --primary-color: #2ecc71;
        --secondary-color: #27ae60;
        --accent-color: #f39c12;
        --dark-color: #2c3e50;
        --light-color: #ffffff;
    }

    .auth-container {
        display: flex;
        min-height: 90vh;
        align-items: center;
        justify-content: center;
        padding: 0rem;
        background-image: url('<%=TRBView.APP_CONTEXT%>/image/loginback.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }

    .auth-card {
        background: var(--light-color);
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 450px;
        padding: 2.5rem;
        position: relative;
        overflow: hidden;
        margin-top: 10px;
    }

    .auth-header {
        text-align: center;
        margin-bottom: 2.5rem;
    }

    .auth-title {
        font-size: 2rem;
        color: var(--dark-color);
        margin-bottom: 0.5rem;
        font-weight: 700;
    }

    .auth-subtitle {
        color: #666;
        margin-bottom: 2rem;
    }

    .form-group {
        margin-bottom: 1.5rem;
        position: relative;
    }

    .input-icon {
        position: absolute;
        left: 1rem;          /* 16px from left */
        top: 50%;
        transform: translateY(-50%);
        color: #999;
        font-size: 1.1rem;
        z-index: 1;          /* Lower z-index */
    }

    .formc {
        display: block;
        width: 78%;
        padding: .375rem .75rem;
        font-size: 1rem;
        font-weight: 400;
        line-height: 1.5;
        margin-left:40px;
        color: var(--bs-body-color);
        background-color: var(--bs-body-bg);
        background-clip: padding-box;
        border: var(--bs-border-width) solid var(--bs-border-color);
        -webkit-appearance: none;
        -moz-appearance: none;
        appearance: none;
        border-radius: var(--bs-border-radius);
        transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
    }

    .forc:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
    }
    .form-control:focus + .input-icon {
        color: var(--primary-color);
        transition: color 0.3s ease;
    }
    .error-message {
        color: #e74c3c;
        font-size: 0.9rem;
        margin-top: 0.5rem;
        display: block;
    }

    .auth-actions {
        display: flex;
        flex-direction: column;
        gap: 1rem;
        margin-top: 2rem;
    }

    .auth-button {
        padding: 1rem;
        border: none;
        border-radius: 8px;
        font-weight: 600;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 0.5rem;
    }

    .primary-btn {
        background: var(--primary-color);
        color: var(--light-color);
    }

    .secondary-btn {
        background: var(--accent-color);
        color: var(--light-color);
    }

    .auth-button:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    .auth-footer {
        text-align: center;
        margin-top: 2rem;
        color: #666;
    }

    .auth-link {
        color: var(--primary-color);
        text-decoration: none;
        font-weight: 500;
    }

    .alert {
        padding: 1rem;
        border-radius: 8px;
        margin-bottom: 1.5rem;
    }

    .alert-error {
        background: #fee2e2;
        color: #991b1b;
    }

    .alert-success {
        background: #dcfce7;
        color: #166534;
    }

    @media (max-width: 480px) {
        .auth-container {
            padding: 1rem;
        }

        .auth-card {
            padding: 1.5rem;
        }
    }
</style>
</head>
<body>
<%@ include file="Header.jsp"%>

<div class="auth-container">
    <div class="auth-card">
        <div class="auth-header">
            <h1 class="auth-title">Welcome Back</h1>
            <p class="auth-subtitle">Sign in to continue to your account</p>
        </div>

        <%-- Error/Success Messages --%>
        <% if (!ServletUtility.getErrorMessage(request).equals("")) { %>
            <div class="alert alert-error">
                <%= ServletUtility.getErrorMessage(request) %>
            </div>
        <% } %>

        <% if (!ServletUtility.getSuccessMessage(request).equals("")) { %>
            <div class="alert alert-success">
                <%= ServletUtility.getSuccessMessage(request) %>
            </div>
        <% } %>

        <form action="<%=TRBView.LOGIN_CTL%>" method="post">
            <jsp:useBean id="bean" class="in.co.turf.booking.bean.UserBean" scope="request"></jsp:useBean>

            <input type="hidden" name="uri" value="<%= request.getAttribute("uri") %>">
            <input type="hidden" name="id" value="<%= bean.getId() %>">
            <input type="hidden" name="createdBy" value="<%= bean.getCreatedBy() %>">
            <input type="hidden" name="modifiedBy" value="<%= bean.getModifiedBy() %>">
            <input type="hidden" name="createdDatetime"
                   value="<%= DataUtility.getTimestamp(bean.getCreatedDatetime()) %>">
            <input type="hidden" name="modifiedDatetime"
                   value="<%= DataUtility.getTimestamp(bean.getModifiedDatetime()) %>">

            <div class="form-group">
                 <i class="fas fa-user input-icon"></i>
                 <input type="text" class="formc" name="userName"
                        value="<%= DataUtility.getStringData(bean.getUserName()) %>"
                        placeholder="Enter username" required>  <!-- Removed spaces from placeholder -->
                 <span class="error-message">
                     <%= ServletUtility.getErrorMessage("userName", request) %>
                 </span>
             </div>

             <div class="form-group">
                 <i class="fas fa-lock input-icon"></i>
                 <input type="password" class="formc" name="password"
                        value="<%= DataUtility.getStringData(bean.getPassword()) %>"
                        placeholder="Enter password" required>  <!-- Removed spaces from placeholder -->
                 <span class="error-message">
                     <%= ServletUtility.getErrorMessage("password", request) %>
                 </span>
             </div>

            <div class="auth-actions">
                <button type="submit" name="operation"
                        value="<%= LoginCtl.OP_SIGN_IN %>"
                        class="auth-button primary-btn">
                    <i class="fas fa-sign-in-alt"></i>
                    Sign In
                </button>

                <button type="button"
                        onclick="window.location.href='<%= TRBView.USER_REGISTRATION_CTL %>'"
                        class="auth-button secondary-btn">
                    <i class="fas fa-user-plus"></i>
                    Create Account
                </button>
            </div>
        </form>

        <div class="auth-footer">
            <a href="#" class="auth-link">Forgot Password?</a>
        </div>
    </div>
</div>

<%@ include file="Footer.jsp"%>

<script>
    // Add floating label animation
    document.querySelectorAll('.form-control').forEach(input => {
        input.addEventListener('focus', () => {
            input.previousElementSibling.style.transform = 'translateY(-30px) scale(0.9)';
        });

        input.addEventListener('blur', () => {
            if (!input.value) {
                input.previousElementSibling.style.transform = 'translateY(-50%)';
            }
        });
    });

    // Toggle password visibility
    const passwordInput = document.querySelector('input[name="password"]');
    const togglePassword = document.createElement('i');
    togglePassword.className = 'fas fa-eye input-icon';
    togglePassword.style.left = 'auto';
    togglePassword.style.right = '1rem';
    togglePassword.style.cursor = 'pointer';

    togglePassword.addEventListener('click', () => {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        togglePassword.classList.toggle('fa-eye-slash');
    });

    document.querySelector('input[name="password"]').parentNode.appendChild(togglePassword);
</script>
</body>
</html>