<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<style>
    .site-footer {
        background: var(--secondary-color);
        color: #ffffff;
        padding: 4rem 0 2rem;
        margin-top: auto;
        font-family: 'Poppins', sans-serif;
         transition: all 0.3s ease-in-out;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1.5rem;
    }

    .footer-content {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 3rem;
        padding-bottom: 3rem;
        border-bottom: 1px solid rgba(255,255,255,0.1);
    }

    .footer-section h5 {
        font-size: 1.25rem;
        font-weight: 600;
        margin-bottom: 1.5rem;
        color: #f39c12;
    }

    .footer-links {
        list-style: none;
        padding: 0;
    }

    .footer-links li {
        margin-bottom: 0.75rem;
    }

    .footer-links a {
        color: rgba(255,255,255,0.8);
        text-decoration: none;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.5rem;
    }

    .footer-links a:hover {
        color: #ffffff;
        transform: translateX(5px);
    }

    .social-links {
        display: flex;
        gap: 1.5rem;
        margin-top: 1.5rem;
    }

    .social-links a {
        color: white;
        font-size: 1.5rem;
        transition: all 0.3s ease;
    }

    .social-links a:hover {
        transform: translateY(-3px);
        color: #f39c12;
    }

    .footer-bottom {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        color: rgba(255,255,255,0.8);
    }

    .footer-bottom a {
        color: #f39c12;
        text-decoration: none;
        transition: all 0.3s ease;
    }

    .footer-bottom a:hover {
        color: #ffffff;
        text-decoration: underline;
    }

    .newsletter-form {
        display: flex;
        gap: 0.5rem;
        margin-top: 1rem;
    }

    .newsletter-input {
        flex: 1;
        padding: 0.75rem;
        border: none;
        border-radius: 5px;
        background: rgba(255,255,255,0.1);
        color: white;
    }

    .newsletter-input::placeholder {
        color: rgba(255,255,255,0.7);
    }

    .newsletter-btn {
        background: #f39c12;
        color: white;
        border: none;
        padding: 0.75rem 1.5rem;
        border-radius: 5px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .newsletter-btn:hover {
        background: #e67e22;
    }

    @media (max-width: 768px) {
        .footer-content {
            grid-template-columns: 1fr;
        }
    }
    body.dark-mode .site-footer {
        background: #34495e;
        border-top: 1px solid #2c3e50;
    }
</style>
</head>
<body>

<!-- Footer -->
<footer class="site-footer">
    <div class="footer-container">
        <div class="footer-content">
            <div class="footer-section">
                <h5>About TurfZone</h5>
                <p>Your premier destination for sports turf bookings. Experience world-class facilities with seamless booking management.</p>
                <div class="social-links">
                    <a href="#" target="_blank"><i class="fab fa-facebook"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-twitter"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-instagram"></i></a>
                    <a href="#" target="_blank"><i class="fab fa-linkedin"></i></a>
                </div>
            </div>

            <div class="footer-section">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="#"><i class="fas fa-chevron-right"></i>Home</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>About Us</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>Our Facilities</a></li>
                    <li><a href="#"><i class="fas fa-chevron-right"></i>Contact</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h5>Contact Info</h5>
                <ul class="footer-links">
                    <li><a href="#"><i class="fas fa-map-marker-alt"></i>Sports City, Turf Road 123</a></li>
                    <li><a href="tel:+1234567890"><i class="fas fa-phone"></i>+1 (234) 567-890</a></li>
                    <li><a href="mailto:info@turfzone.com"><i class="fas fa-envelope"></i>info@turfzone.com</a></li>
                </ul>
            </div>

            <div class="footer-section">
                <h5>Newsletter</h5>
                <p>Subscribe for updates and special offers:</p>
                <form class="newsletter-form">
                    <input type="email" class="newsletter-input" placeholder="Enter your email">
                    <button type="submit" class="newsletter-btn">Subscribe</button>
                </form>
            </div>
        </div>

        <div class="footer-bottom">
            <p>&copy; <%= new Date().getYear() + 1900 %> <a href="#">Turf Booking System</a>. All rights reserved.
            <span style="margin: 0 10px">|</span>
            <a href="#">Privacy Policy</a>
            <span style="margin: 0 10px">|</span>
            <a href="#">Terms of Service</a></p>
        </div>
    </div>
</footer>

</body>
</html>