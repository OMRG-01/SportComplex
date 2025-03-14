<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.bean.BookingBean"%>
<%@page import="in.co.turf.booking.ctl.BookingListCtl"%>
<%@page import="in.co.turf.booking.ctl.ManageTurfListCtl"%>
<%@page import="in.co.turf.booking.bean.ManageTurfBean"%>
<%@page import="in.co.turf.booking.bean.TurfBean"%>
<%@page import="in.co.turf.booking.ctl.TurfListCtl"%>
<%@page import="in.co.turf.booking.ctl.UserListCtl"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>TurfZone - Premium Sports Booking</title>
<style>
    :root {
        --text-color: #2c3e50;
        --primary-color: #2ecc71;
        --secondary-color: #27ae60;
        --accent-color: #f39c12;
        --dark-color: #2c3e50;
        --light-color: #ffffff;
    }

    .hero-section {
        position: relative;
        height: 90vh;
        overflow: hidden;
        margin-top: 1px;
    }

    .hero-carousel {
        height: 100%;
        position: relative;
    }

    .carousel-item {
        position: absolute;
        width: 100%;
        height: 100%;
        opacity: 0;
        transition: opacity 1s ease, transform 10s linear;
    }
    .carousel-item a{
            text-decoration: none;
        }
    .carousel-item.active {
        opacity: 1;
        z-index: 1;
    }

    .carousel-item img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        object-position: center;
        transform: scale(1.1);
        transition: transform 10s ease;
    }

    .carousel-item.active img {
        transform: scale(1);
    }

    .hero-content {
        position: absolute;
        top: 50%;
        left: 10%;
        transform: translateY(-50%);
        color: var(--light-color);
        max-width: 600px;
        z-index: 2;
    }

    .hero-title {
        font-size: 3.5rem;
        font-weight: 700;
        margin-bottom: 1.5rem;
        line-height: 1.2;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        animation: slideInLeft 1s ease-out;
    }

    .hero-subtitle {
        font-size: 1.5rem;
        margin-bottom: 2rem;
        animation: slideInRight 1s ease-out;

    }

    .cta-buttons {
        display: flex;
        gap: 1.5rem;
        animation: fadeInUp 0.8s ease-out;
    }

    .cta-button {
        padding: 1rem 2rem;
        border-radius: 50px;
        font-weight: 600;
        text-transform: uppercase;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        gap: 0.8rem;
    }

    .primary-cta {
        background: var(--accent-color);
        color: var(--light-color);
        border: 2px solid var(--accent-color);
    }

    .secondary-cta {
        background: transparent;
        color: var(--light-color);
        border: 2px solid var(--light-color);
    }

    .cta-button:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.3);
    }

    .carousel-controls {
        position: absolute;
        bottom: 2rem;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 1rem;
        z-index: 3;
    }

    .control-dot {
        width: 15px;
        height: 15px;
        border-radius: 50%;
        background: rgba(255,255,255,0.5);
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .control-dot.active {
        background: var(--light-color);
        transform: scale(1.2);
    }

    .features-section {
        padding: 5rem 2rem;
        background: var(--light-color);
    }

    .features-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
        gap: 2rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    .feature-card {
        padding: 2rem;
        border-radius: 15px;
        background: var(--light-color);
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        text-align: center;
    }

    .feature-card:hover {
        transform: translateY(-10px);
    }

    .feature-icon {
        font-size: 2.5rem;
        color: var(--primary-color);
        margin-bottom: 1rem;
    }

    @keyframes slideInLeft {
        from { transform: translateX(-100px); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }

    @keyframes slideInRight {
        from { transform: translateX(100px); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }

    @keyframes fadeInUp {
        from { opacity: 0; transform: translateY(20px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @media (max-width: 768px) {
        .hero-title {
            font-size: 2.5rem;
        }

        .hero-subtitle {
            font-size: 1.2rem;
        }

        .cta-buttons {
            flex-direction: column;
        }
    }
    .welcome-container {
            padding: 4rem ;
            min-height: calc(100vh - 100px);
            background: transparent !important;
        }
    .welcome-container a{
            text-decoration:none;
            }
        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            max-width: 1200px;
            margin: 0 auto;
            position: relative;
                z-index: 1;
        }
        #particles-js {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 0;
        }

        .service-card {
            background: var(--light-color);
            border-radius: 15px;
            padding: 2rem;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }
           body.dark-mode #particles-js {
               background: rgba(0, 0, 0, 0.3);
           }
        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.2);
        }

        .card-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .card-title {
            font-size: 1.5rem;
            color: var(--dark-color);
            margin-bottom: 1rem;
        }

        .card-description {
            color: #666;
            margin-bottom: 1.5rem;
        }

        /* Dark mode styles */
        body.dark-mode .service-card {
            background: #34495e;
        }

        body.dark-mode .card-title {
            color: var(--light-color);
        }

        body.dark-mode .card-description {
            color: #bdc3c7;
        }

        @media (max-width: 768px) {
            .welcome-container {
                padding: 2rem 1rem;
            }

            .card-grid {
                grid-template-columns: 1fr;
            }
        }

</style>
<script src="https://cdn.jsdelivr.net/particles.js/2.0.0/particles.min.js"></script>
</head>
<body>
<%@ include file="Header.jsp" %>

<main>

    <% if (userLoggedIn) { %>

<div class="welcome-container">
    <div id="particles-js"></div>
    <div class="card-grid">
        <!-- Book Now Card -->
        <div class="service-card">
            <i class="fas fa-calendar-check card-icon"></i>
            <h3 class="card-title">Instant Booking</h3>
            <p class="card-description">Reserve your preferred turf instantly with our easy-to-use booking system</p>
            <a href="<%=TRBView.BOOKING_CTL%>" class="cta-button primary-cta">
                Book Now
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>

        <!-- Explore Turfs Card -->
        <div class="service-card">
            <i class="fas fa-search-location card-icon"></i>
            <h3 class="card-title">Explore Facilities</h3>
            <p class="card-description">Discover premium turfs with detailed information and photos</p>
            <a href="<%=TRBView.TURF_LIST_CTL%>" class="cta-button primary-cta">
                View Turfs
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>

        <!-- Availability Card -->
        <div class="service-card">
            <i class="fas fa-clock card-icon"></i>
            <h3 class="card-title">Check Availability</h3>
            <p class="card-description">Real-time slot availability for your preferred time and date</p>
            <a href="<%=TRBView.MANAGE_TURF_LIST_CTL%>" class="cta-button primary-cta">
                Check Slots
                <i class="fas fa-arrow-right"></i>
            </a>
        </div>
    </div>


</div>


<% }else{  %>


    <section class="hero-section">
        <div class="hero-carousel">
            <div class="carousel-item active">
                <img src="<%=TRBView.APP_CONTEXT%>/image/soccer.jpg" alt="Premium Turf">
                <div class="hero-content">
                    <h1 class="hero-title">Premium Sports Experience</h1>
                    <p class="hero-subtitle">Book world-class turf facilities with instant confirmation</p>
                    <div class="cta-buttons">
                        <a href="<%=TRBView.BOOKING_CTL%>" class="cta-button primary-cta">
                            <i class="fas fa-calendar-check"></i>
                            Book Now
                        </a>
                        <a href="<%=TRBView.TURF_LIST_CTL%>" class="cta-button primary-cta">
                            <i class="fas fa-search-location"></i>
                            Explore Turfs
                        </a>
                    </div>
                </div>
            </div>
            <div class="carousel-item active">
                            <img src="<%=TRBView.APP_CONTEXT%>/image/cricket2.jpg" alt="Premium Turf">
                            <div class="hero-content">
                                <h1 class="hero-title">Premium Sports Experience</h1>
                                <p class="hero-subtitle">Book world-class turf facilities with instant confirmation</p>
                                <div class="cta-buttons">
                                    <a href="<%=TRBView.BOOKING_CTL%>" class="cta-button primary-cta">
                                        <i class="fas fa-calendar-check"></i>
                                        Book Now
                                    </a>
                                    <a href="<%=TRBView.TURF_LIST_CTL%>" class="cta-button primary-cta">
                                        <i class="fas fa-search-location"></i>
                                        Explore Turfs
                                    </a>
                                </div>
                            </div>
                        </div>

            <!-- Add other carousel items similarly -->
        </div>

        <div class="carousel-controls">
            <div class="control-dot active"></div>
            <div class="control-dot"></div>
            <div class="control-dot"></div>
        </div>
    </section>

    <section class="features-section">
        <div class="features-grid">
            <div class="feature-card">
                <i class="fas fa-clock feature-icon"></i>
                <h3>24/7 Availability</h3>
                <p>Book anytime with our premium lighting facilities</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-shield-alt feature-icon"></i>
                <h3 >Secure Booking</h3>
                <p>100% secure payments with instant confirmation</p>
            </div>
            <div class="feature-card">
                <i class="fas fa-trophy feature-icon"></i>
                <h3>Professional Quality</h3>
                <p>FIFA-approved turfs with premium maintenance</p>
            </div>
        </div>
    </section>


    <% } %>
</main>

<%@ include file="Footer.jsp" %>

<script>
    // Enhanced Carousel Logic
    let currentSlide = 0;
    const slides = document.querySelectorAll('.carousel-item');
    const dots = document.querySelectorAll('.control-dot');
    const totalSlides = slides.length;

    function updateDots() {
        dots.forEach((dot, index) => {
            dot.classList.toggle('active', index === currentSlide);
        });
    }

    function showSlide(n) {
        currentSlide = (n + totalSlides) % totalSlides;
        slides.forEach((slide, index) => {
            slide.classList.toggle('active', index === currentSlide);
        });
        updateDots();
    }

    // Add dot click functionality
    dots.forEach((dot, index) => {
        dot.addEventListener('click', () => showSlide(index));
    });

    // Auto-play with pause
    let autoPlay = setInterval(() => showSlide(currentSlide + 1), 6000);

    document.querySelector('.hero-section').addEventListener('mouseenter', () => {
        clearInterval(autoPlay);
    });

    document.querySelector('.hero-section').addEventListener('mouseleave', () => {
        autoPlay = setInterval(() => showSlide(currentSlide + 1), 6000);
    });

    // Touch/swipe support
    let touchStartX = 0;
    document.querySelector('.hero-section').addEventListener('touchstart', e => {
        touchStartX = e.touches[0].clientX;
    });

    document.querySelector('.hero-section').addEventListener('touchend', e => {
        const touchEndX = e.changedTouches[0].clientX;
        const diff = touchStartX - touchEndX;
        if (Math.abs(diff) > 50) {
            diff > 0 ? showSlide(currentSlide + 1) : showSlide(currentSlide - 1);
        }
    });

document.addEventListener('DOMContentLoaded', function() {
    if(document.getElementById('particles-js')) {
        particlesJS('particles-js', {
             particles: {
                           number: {
                               value: 80,  // Increased number of particles
                               density: {
                                   enable: true,
                                   value_area: 800
                               }
                           },
                color: { value: primaryColor },
                opacity: {
                    value: 0.5,
                    random: true,
                    anim: { enable: true, speed: 1, opacity_min: 0.1 }
                },
                size: {
                    value: 3,
                    random: true,
                    anim: { enable: true, speed: 2, size_min: 0.1 }
                },
               line_linked: {
                                   enable: true,
                                   distance: 150,
                                   color: textColor,
                                   opacity: 0.4,
                                   width: 1
                               },
                               move: {
                                   enable: true,
                                   speed: 2,
                    direction: "none",
                    random: false,
                    straight: false,
                    out_mode: "out",
                    bounce: false
                }
            },
            interactivity: {
                detect_on: "canvas",
                events: {
                    onhover: { enable: true, mode: "repulse" },
                    onclick: { enable: true, mode: "push" },
                    resize: true
                }
            },
            retina_detect: true
        });
    }
});

// Add this function to update particles when theme changes
function updateParticlesTheme() {
    if(typeof pJSDom !== 'undefined' && pJSDom.length > 0) {
        const primary = getComputedStyle(document.documentElement)
            .getPropertyValue('--primary-color').trim();
        const text = getComputedStyle(document.documentElement)
            .getPropertyValue('--text-color').trim();

        pJSDom[0].pJS.particles.color.value = primary;
        pJSDom[0].pJS.particles.line_linked.color = text;
        pJSDom[0].pJS.fn.vendors.refresh();
    }
}

</script>
</body>
</html>