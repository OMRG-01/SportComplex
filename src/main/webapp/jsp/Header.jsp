<%@page import="in.co.turf.booking.ctl.LoginCtl"%>
<%@page import="in.co.turf.booking.ctl.TRBView"%>
<%@page import="in.co.turf.booking.bean.UserBean"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Turf Booking System</title>

<!-- Google Fonts -->
<link rel="stylesheet"
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Font Awesome -->
<link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<!-- Custom Styles -->
<style>
    :root {
        --primary-color: #1abc9c;
        --secondary-color: #16a085;
        --accent-color: #f39c12;
        --dark-color: #2c3e50;
        --light-color: #ffffff;
    }

    .navbar {
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        padding: 0.8rem 1.5rem;
        box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    }

    .navbar-brand {
        font-size: 1.8rem;
        font-weight: 700;
        font-family: 'Poppins', sans-serif;
        color: var(--light-color) !important;
        display: flex;
        align-items: center;
        gap: 0.8rem;
    }

    .brand-icon {
        font-size: 2.2rem;
        color: var(--accent-color);
    }

    .nav-item {
        margin: 0 0.5rem;
        position: relative;
    }

    .nav-link {
        font-size: 1.1rem;
        font-weight: 500;
        color: var(--light-color) !important;
        padding: 0.8rem 1.2rem !important;
        border-radius: 8px;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        display: flex;
        align-items: center;
        gap: 0.6rem;
    }

    .nav-link:hover {
        background: rgba(255,255,255,0.15);
        color: var(--accent-color) !important;
        transform: translateY(-2px);
    }

    .nav-link i {
        width: 24px;
        text-align: center;
    }

    .dropdown-menu {
        background: var(--secondary-color);
        border: none;
        border-radius: 12px;
        padding: 0.5rem;
        box-shadow: 0 8px 24px rgba(0,0,0,0.15);
        margin-top: 0.8rem !important;
    }

    .dropdown-item {
        color: var(--light-color) !important;
        padding: 0.75rem 1.5rem !important;
        border-radius: 8px;
        margin: 0.25rem 0;
        display: flex;
        align-items: center;
        gap: 0.8rem;
        transition: all 0.2s ease;
    }

    .dropdown-item:hover {
        background: var(--primary-color) !important;
        transform: translateX(5px);
    }

    .dark-mode-toggle {
        background: rgba(255,255,255,0.1);
        border: 2px solid rgba(255,255,255,0.2);
        border-radius: 50px;
        padding: 0.5rem 1rem;
        color: var(--light-color);
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.6rem;
    }

    .dark-mode-toggle:hover {
        background: rgba(255,255,255,0.2);
        transform: scale(1.05);
    }

    .dark-mode {
        background-color: var(--dark-color) !important;
        color: var(--light-color) !important;
    }

    .dark-mode .navbar {
        background: linear-gradient(135deg, #34495e, #2c3e50);
    }

    .dark-mode .dropdown-menu {
        background: #2c3e50;
    }
    /* Add these dark mode styles */
    body.dark-mode .site-footer {
        background: #2c3e50;
        color: #ecf0f1;
    }

    body.dark-mode .footer-links a {
        color: #bdc3c7;
    }

    body.dark-mode .footer-links a:hover {
        color: #ecf0f1;
    }

    body.dark-mode .footer-section h5 {
        color: #f39c12;
    }

    body.dark-mode .newsletter-input {
        background: rgba(0,0,0,0.3);
    }
    .navbar-toggler {
        border: none;
        padding: 0.5rem;
    }

    .navbar-toggler:focus {
        box-shadow: none;
    }

    .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 1)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
    }

    @media (max-width: 992px) {
        .navbar-collapse {
            background: var(--secondary-color);
            padding: 1rem;
            margin-top: 1rem;
            border-radius: 12px;
        }

        .dropdown-menu {
            background: rgba(0,0,0,0.1);
            margin-left: 1.5rem;
            width: 90%;
        }
    }
</style>
</head>
<body>

<%
    UserBean userBean = (UserBean) session.getAttribute("user");
    boolean userLoggedIn = userBean != null;
    String welcomeMsg = userLoggedIn ? "Hi, " + userBean.getName() : "Hi, Guest";
%>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-dark sticky-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="<%=TRBView.WELCOME_CTL%>">
            <i class="fas fa-futbol brand-icon"></i>
            TurfZone
        </a>

        <!-- Dark Mode Toggle -->
        <button class="dark-mode-toggle me-3" onclick="toggleDarkMode()">
            <i class="fas fa-moon"></i>
            <span>Dark Mode</span>
        </button>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
            aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">

                <li class="nav-item">
                    <a class="nav-link" href="<%=TRBView.WELCOME_CTL%>">
                        <i class="fas fa-home"></i>
                        Home
                    </a>
                </li>

                <% if (userLoggedIn) { %>

                    <% if (userBean.getRoleId() == 1) { %>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.USER_LIST_CTL%>">
                                <i class="fas fa-users"></i>
                                Users
                            </a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" href="#" role="button"
                                data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fa-solid fa-volleyball"></i>
                                Turf
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="<%=TRBView.TURF_CTL%>">
                                    <i class="fas fa-plus-circle"></i> Add Turf
                                </a></li>
                                <li><a class="dropdown-item" href="<%=TRBView.TURF_LIST_CTL%>">
                                    <i class="fas fa-list"></i> Turf List
                                </a></li>
                            </ul>
                        </li>
                <li class="nav-item dropdown">
                                            <a class="nav-link dropdown-toggle" href="#" role="button"
                                                data-bs-toggle="dropdown" aria-expanded="false">
                                                <i class="fas fa-tractor"></i>
                                                Turf Slot
                                            </a>
                                            <ul class="dropdown-menu">
                                                <li><a class="dropdown-item" href="<%=TRBView.MANAGE_TURF_CTL%>">
                                                    <i class="fas fa-plus-circle"></i> Add Slot
                                                </a></li>
                                                <li><a class="dropdown-item" href="<%=TRBView.MANAGE_TURF_LIST_CTL%>">
                                                    <i class="fas fa-list"></i> Turf Slot List
                                                </a></li>
                                            </ul>
                                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.BOOKING_LIST_CTL%>">
                                <i class="fas fa-calendar-check"></i>
                                Bookings
                            </a>
                        </li>

                    <% } else if (userBean.getRoleId() == 2) { %>

                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.TURF_LIST_CTL%>">
                                <i class="fas fa-search-location"></i>
                                Find Turf
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.MANAGE_TURF_LIST_CTL%>">
                                <i class="fas fa-clock"></i>
                                Availability
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.BOOKING_CTL%>">
                                <i class="fas fa-calendar-plus"></i>
                                Book Now
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="<%=TRBView.BOOKING_LIST_CTL%>">
                                <i class="fas fa-history"></i>
                                History
                            </a>
                        </li>

                    <% } %>

                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-info-circle"></i>
                            About
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fas fa-phone-alt"></i>
                            Contact
                        </a>
                    </li>
                <% } %>

            </ul>

            <ul class="navbar-nav ms-3">
                <% if (userLoggedIn) { %>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button"
                            data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fas fa-user-circle"></i>
                            <%= welcomeMsg %>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="<%=TRBView.MY_PROFILE_CTL%>">
                                <i class="fas fa-user-cog"></i> Profile
                            </a></li>
                            <li><a class="dropdown-item" href="<%=TRBView.CHANGE_PASSWORD_CTL%>">
                                <i class="fas fa-lock"></i> Change Password
                            </a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="<%=TRBView.LOGIN_CTL%>?operation=<%=LoginCtl.OP_LOG_OUT%>">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a></li>
                        </ul>
                    </li>
                <% } else { %>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=TRBView.LOGIN_CTL%>">
                            <i class="fas fa-sign-in-alt"></i>
                            Sign In
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=TRBView.USER_REGISTRATION_CTL%>">
                            <i class="fas fa-user-plus"></i>
                            Sign Up
                        </a>
                    </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function toggleDarkMode() {
        const body = document.body;
        body.classList.toggle('dark-mode');

        // Toggle footer dark mode
        const footer = document.querySelector('.site-footer');
        if(footer) footer.classList.toggle('dark-mode');

        // Store preference
        const isDark = body.classList.contains('dark-mode');
        localStorage.setItem('darkMode', isDark);

        // Update toggle button icon
        const icon = document.querySelector('.dark-mode-toggle i');
        icon.className = isDark ? 'fas fa-sun' : 'fas fa-moon';
    }
    // Initialize dark mode from localStorage
    document.addEventListener('DOMContentLoaded', () => {
        const isDark = localStorage.getItem('darkMode') === 'true';
        if(isDark) {
            document.body.classList.add('dark-mode');
            document.querySelector('.dark-mode-toggle i').className = 'fas fa-sun';
        }
    });
    // Add smooth scroll behavior
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            document.querySelector(this.getAttribute('href')).scrollIntoView({
                behavior: 'smooth'
            });
        });
    });
</script>

</body>
</html>