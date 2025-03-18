<%@page import="in.co.turf.booking.ctl.ManageTurfCtl"%>
<%@page import="java.util.List"%>
<%@page import="in.co.turf.booking.util.HTMLUtility"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Book Turf</title>
<!-- Flatpickr CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<style>
:root {
    --primary-color: #2ecc71;
    --secondary-color: #27ae60;
    --accent-color: #f39c12;
    --light-color: #ffffff;
    --dark-color: #2c3e50;
    --text-color: #2c3e50;
    --bg-gradient: linear-gradient(135deg, #2ecc71, #27ae60);
}

body.dark-mode {
    --text-color: #ecf0f1;
    --dark-color: #34495e;
    --bg-gradient: linear-gradient(135deg, #34495e, #2c3e50);
}

.booking-container {
    max-width: 800px;
    margin: 2rem auto;
    padding: 2rem;
}

.booking-header {
    background: var(--bg-gradient);
    color: var(--light-color);
    padding: 2rem;
    border-radius: 15px;
    margin-bottom: 2rem;
    text-align: center;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.booking-card {
    background: var(--light-color);
    border-radius: 15px;
    padding: 2rem;
    box-shadow: 0 4px 25px rgba(0,0,0,0.1);
}

.form-icon {
    color: var(--primary-color);
    font-size: 1.2rem;
    margin-right: 0.8rem;
}

.custom-select {
    width: 100%;
    padding: 0.8rem;
    border: 2px solid var(--primary-color);
    border-radius: 8px;
    background: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%232ecc71' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M2 5l6 6 6-6'/%3e%3c/svg%3e") no-repeat right 0.75rem center/16px 12px;
    appearance: none;
    transition: all 0.3s ease;
}

.custom-select:focus {
    border-color: var(--secondary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.25);
}

.date-input {
    position: relative;
}

.date-input input {
    padding-left: 2.5rem;
}

.date-input i {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary-color);
}

.btn-booking {
    background: var(--primary-color);
    color: var(--light-color);
    padding: 0.8rem 2rem;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.btn-booking:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
}

/* Dark mode adjustments */
body.dark-mode .booking-card {
    background: var(--dark-color);
    color: var(--light-color);
    border-radius: 15px;
}

body.dark-mode .custom-select {
    background-color: #34495e;
    border-color: var(--primary-color);
    color: var(--light-color);
}

body.dark-mode .date-input i {
    color: var(--light-color);
}

.error-message {
    color: #e74c3c;
    font-size: 0.9rem;
    margin-top: 0.5rem;
    display: block;
}
.date-picker-container {
    position: relative;
    margin-bottom: 1.5rem;
}

.flatpickr-input {
    width: 100%;
    padding: 0.8rem 1rem;
    border: 2px solid var(--primary-color);
    border-radius: 8px;
    font-size: 1rem;
    background: var(--light-color);
    color: var(--text-color);
    padding-left: 2.5rem;
    transition: all 0.3s ease;
}

.flatpickr-input:focus {
    border-color: var(--secondary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.25);
}

.date-icon {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary-color);
    z-index: 2;
}

/* Flatpickr Customization */
.flatpickr-calendar {
    border-radius: 8px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    font-family: inherit;
}

.flatpickr-day.selected,
.flatpickr-day.startRange,
.flatpickr-day.endRange,
.flatpickr-day.selected.inRange,
.flatpickr-day.startRange.inRange,
.flatpickr-day.endRange.inRange,
.flatpickr-day.selected:focus,
.flatpickr-day.startRange:focus,
.flatpickr-day.endRange:focus,
.flatpickr-day.selected:hover,
.flatpickr-day.startRange:hover,
.flatpickr-day.endRange:hover {
    background: var(--primary-color);
    border-color: var(--primary-color);
}

.flatpickr-current-month .numInputWrapper span.arrowUp:after {
    border-bottom-color: var(--primary-color);
}

.flatpickr-current-month .numInputWrapper span.arrowDown:after {
    border-top-color: var(--primary-color);
}
.flatpickr-calendar {
    z-index: 1000 !important;
}

/* Dark mode styles */
body.dark-mode .flatpickr-calendar {
    background: var(--dark-color);
    color: var(--light-color);
}

body.dark-mode .flatpickr-day {
    color: var(--light-color);
}

body.dark-mode .flatpickr-day:hover {
    background: rgba(255,255,255,0.1);
}

body.dark-mode .flatpickr-day.today {
    border-color: var(--primary-color);
}

body.dark-mode .flatpickr-months .flatpickr-month,
body.dark-mode .flatpickr-weekdays,
body.dark-mode .flatpickr-weekday {
    color: var(--light-color);
    fill: var(--light-color);
}

body.dark-mode .flatpickr-current-month input.cur-year {
    color: var(--light-color);
}
/* Add these styles to your existing CSS */
.custom-select-wrapper {
    position: relative;
    margin-top: 0.5rem;
}

.custom-select-wrapper select {
    width: 100%;
    padding: 0.8rem 2.5rem 0.8rem 1rem;
    border: 2px solid var(--primary-color);
    border-radius: 8px;
    appearance: none;
    background-color: var(--light-color);
    color: var(--text-color);
    font-size: 1rem;
    transition: all 0.3s ease;
}

.custom-select-wrapper::after {
    content: "\f078";
    font-family: "Font Awesome 5 Free";
    position: absolute;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary-color);
    font-weight: 900;
    pointer-events: none;
}

.custom-select-wrapper select:focus {
    border-color: var(--secondary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.25);
    outline: none;
}

/* Dark mode adjustments */
body.dark-mode .custom-select-wrapper select {
    background-color: var(--dark-color);
    color: var(--light-color);
    border-color: var(--primary-color);
}

body.dark-mode .custom-select-wrapper::after {
    color: var(--light-color);
}

</style>
</head>
<body>
<%@ include file="Header.jsp"%>

<div class="booking-container">
    <div class="booking-header">
        <h1 class="display-5 mb-3">Book Your Turf</h1>
        <p class="lead">Secure your playing time with our easy booking system</p>
    </div>

    <div class="booking-card">
        <!-- Messages Section -->
        <% if (!ServletUtility.getErrorMessage(request).isEmpty()) { %>
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <%=ServletUtility.getErrorMessage(request)%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <% if (!ServletUtility.getSuccessMessage(request).isEmpty()) { %>
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            <%=ServletUtility.getSuccessMessage(request)%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <form action="<%=TRBView.BOOKING_CTL%>" method="post" class="needs-validation" novalidate>
            <jsp:useBean id="bean" class="in.co.turf.booking.bean.BookingBean" scope="request"></jsp:useBean>

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <input type="hidden" name="createdBy" value="<%=bean.getCreatedBy()%>">
            <input type="hidden" name="modifiedBy" value="<%=bean.getModifiedBy()%>">
            <input type="hidden" name="createdDatetime" value="<%=DataUtility.getTimestamp(bean.getCreatedDatetime())%>">
            <input type="hidden" name="modifiedDatetime" value="<%=DataUtility.getTimestamp(bean.getModifiedDatetime())%>">

            <%
                List list = (List) request.getAttribute("turfList");
                List list1 = (List) request.getAttribute("slotList");
            %>

            <!-- Turf Selection -->
            <div class="mb-4">
                <label class="form-label h5">
                    <i class="fas fa-map-marker-alt form-icon"></i>Select Turf
                </label>
                <div class="custom-select-wrapper">
                    <%=HTMLUtility.getList1("turfId", String.valueOf(bean.getTurfId()), list)%>
                </div>
                <div class="error-message">
                    <%=ServletUtility.getErrorMessage("turfId", request)%>
                </div>
            </div>

            <!-- Slot Selection -->
            <div class="mb-4">
                <label class="form-label h5">
                    <i class="fas fa-clock form-icon"></i>Select Time Slot
                </label>
                <div class="custom-select-wrapper">
                    <%=HTMLUtility.getList("slotId", String.valueOf(bean.getSlotId()), list1)%>
                </div>
                <div class="error-message">
                    <%=ServletUtility.getErrorMessage("slotId", request)%>
                </div>
            </div>

            <!-- Date Selection -->
            <div class="mb-4">
                <label class="form-label h5">
                    <i class="fas fa-calendar-alt form-icon"></i>Select Date
                </label>
                <div class="date-picker-container">
                    <i class="fas fa-calendar-day date-icon"></i>
                    <input type="text"
                           class="flatpickr-input"
                           name="date"
                           placeholder="Select Date"
                           data-date-format="d/m/Y"
                           value="<%=DataUtility.getDateString(bean.getDate())%>"
                           required>
                    <div class="error-message">
                        <%=ServletUtility.getErrorMessage("date", request)%>
                    </div>
                </div>
            </div>

            <!-- Action Buttons -->
            <div class="d-grid gap-3 d-md-flex justify-content-md-end mt-4">
                <button type="submit" name="operation" value="<%=ManageTurfCtl.OP_SAVE%>"
                        class="btn btn-booking">
                    <i class="fas fa-check-circle me-2"></i>Confirm Booking
                </button>
                <button type="submit" name="operation" value="<%=ManageTurfCtl.OP_RESET%>"
                        class="btn btn-outline-secondary">
                    <i class="fas fa-redo me-2"></i>Reset
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="Footer.jsp"%>

<!-- Required Scripts -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>

<script>
// Initialize after DOM loads
document.addEventListener('DOMContentLoaded', function() {
    // Debug: Check if Flatpickr exists
    if(typeof flatpickr === 'undefined') {
        console.error('Flatpickr not loaded! Check CDN connection');
        return;
    }

    // Initialize date picker with error handling
    try {
        const pickerInstance = flatpickr('.flatpickr-input', {
            dateFormat: "d/m/Y",
            minDate: "today",
            disableMobile: false, // Enable mobile-friendly version
            static: true,
            onReady: function(selectedDates, dateStr, instance) {
                console.log('Flatpickr initialized successfully');
            },
            onChange: function(selectedDates, dateStr, instance) {
                console.log('Date selected:', dateStr);
                instance.close();
            }
        });

        // Debug: Check instance
        if(!pickerInstance) {
            console.error('Failed to initialize Flatpickr');
            return;
        }

        // Convert initial date value
        const inputElement = document.querySelector('.flatpickr-input');
        if(inputElement && inputElement.value) {
            console.log('Initial date value:', inputElement.value);
            try {
                const parsedDate = new Date(inputElement.value);
                if(!isNaN(parsedDate)) {
                    const formattedDate = flatpickr.formatDate(parsedDate, "d/m/Y");
                    console.log('Formatted date:', formattedDate);
                    inputElement.value = formattedDate;
                }
            } catch(e) {
                console.error('Date formatting error:', e);
            }
        }
    } catch(e) {
        console.error('Flatpickr initialization error:', e);
    }
});

// Global error handling
window.addEventListener('error', function(e) {
    console.error('Script Error:', e.message, 'in', e.filename, 'line', e.lineno);
});
</script>
</body>
</html>