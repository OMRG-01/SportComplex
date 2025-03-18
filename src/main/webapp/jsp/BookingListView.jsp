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
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Booking List | TurfZone</title>
<style>
:root {
    --primary-color: #2ecc71;
    --secondary-color: #27ae60;
    --accent-color: #f39c12;
    --light-color: #ffffff;
    --dark-color: #2c3e50;
    --bg-gradient: linear-gradient(135deg, #2ecc71, #27ae60);
}

.booking-container {
    max-width: 1400px;
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
    border: 2px solid rgba(255,255,255,0.2);
}

.filter-card {
    background: var(--light-color);
    border-radius: 15px;
    padding: 2rem;
    box-shadow: 0 4px 25px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.search-input {
    position: relative;
    margin-bottom: 1rem;
}

.search-input i {
    position: absolute;
    left: 1rem;
    top: 50%;
    transform: translateY(-50%);
    color: var(--primary-color);
}

.search-input input {
    padding-left: 2.5rem;
    border: 2px solid #e0e0e0;
    border-radius: 8px;
    transition: all 0.3s ease;
}

.search-input input:focus {
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.25);
}

.data-table {
    background: var(--light-color);
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 4px 25px rgba(0,0,0,0.1);
}

.data-table thead {
    background: var(--bg-gradient);
    color: var(--light-color);
}

.data-table th {
    border-bottom: 2px solid var(--primary-color) !important;
    padding: 1rem 1.5rem;
}

.data-table td {
    padding: 1rem 1.5rem;
    vertical-align: middle;
}

.pagination-controls {
    display: flex;
    justify-content: flex-end;
    gap: 1rem;
    margin-top: 2rem;
}

.btn-pagination {
    background: var(--primary-color);
    color: var(--light-color);
    border-radius: 8px;
    padding: 0.5rem 1.5rem;
    transition: all 0.3s ease;
}

.btn-pagination:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(46, 204, 113, 0.3);
}

/* Dark mode adjustments */
body.dark-mode .filter-card,
body.dark-mode .data-table {
    background: var(--dark-color);
}

body.dark-mode .search-input input {
    background: #34495e;
    border-color: #2c3e50;
    color: var(--light-color);
}
</style>
</head>
<body>
    <%@ include file="Header.jsp"%>

    <div class="booking-container">
        <div class="booking-header">
            <h2 class="mb-3">Booking Management</h2>
            <p class="lead">View and manage all turf reservations</p>
        </div>

        <!-- Alerts -->
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

        <!-- Filter Card -->
        <div class="filter-card">
            <form action="<%=TRBView.BOOKING_LIST_CTL%>" method="post">
                <div class="row g-4">
                    <div class="col-md-4">
                        <div class="search-input">
                            <i class="fas fa-search"></i>
                            <input type="text" class="form-control"
                                   placeholder="Search by Turf Name" name="name"
                                   value="<%=ServletUtility.getParameter("name", request)%>">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="search-input">
                            <i class="fas fa-user"></i>
                            <input type="text" class="form-control"
                                   placeholder="Search by User Name" name="userName"
                                   value="<%=ServletUtility.getParameter("userName", request)%>">
                        </div>
                    </div>
                    <div class="col-md-4 d-flex align-items-center gap-3">
                        <button type="submit" name="operation"
                                class="btn btn-primary flex-grow-1"
                                value="<%=BookingListCtl.OP_SEARCH%>">
                            <i class="fas fa-filter me-2"></i>Apply Filters
                        </button>
                        <button type="submit" name="operation"
                                class="btn btn-outline-secondary"
                                value="<%=BookingListCtl.OP_RESET%>">
                            <i class="fas fa-redo me-2"></i>Reset
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Data Table -->
        <div class="data-table">
            <table class="table table-hover mb-0">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Turf Name</th>
                        <th>User</th>
                        <th>Time Slot</th>
                        <th>Location</th>
                        <th>Date</th>
                        <th>Amount</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;
                    int size = ServletUtility.getSize(request);
                    BookingBean bean = null;
                    List list = ServletUtility.getList(request);
                    Iterator<BookingBean> iterator = list.iterator();
                    while (iterator.hasNext()) {
                        bean = iterator.next();
                    %>
                    <tr>
                        <td><%=index++%></td>
                        <td><%=bean.getTurfName()%></td>
                        <td><%=bean.getUserName()%></td>
                        <td><span class="badge bg-primary"><%=bean.getTime()%></span></td>
                        <td><%=bean.getTurfLocation()%></td>
                        <td><i class="fas fa-calendar-day me-2"></i><%=DataUtility.getDateString(bean.getDate())%></td>
                        <td>₹<%=bean.getAmount()%></td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination-controls">
            <form action="<%=TRBView.BOOKING_LIST_CTL%>" method="post">
                <input type="hidden" name="pageNo" value="<%=pageNo%>">
                <input type="hidden" name="pageSize" value="<%=pageSize%>">

                <button type="submit" name="operation"
                        class="btn btn-pagination <%= (pageNo == 1) ? "disabled" : "" %>"
                        value="<%=ManageTurfListCtl.OP_PREVIOUS%>">
                    <i class="fas fa-chevron-left me-2"></i>Previous
                </button>

                <button type="submit" name="operation"
                        class="btn btn-pagination <%= ((list.size() < pageSize) || size == pageNo * pageSize) ? "disabled" : "" %>"
                        value="<%=ManageTurfListCtl.OP_NEXT%>">
                    Next<i class="fas fa-chevron-right ms-2"></i>
                </button>
            </form>
        </div>
    </div>

    <%@ include file="Footer.jsp"%>

    <script>
    // Initialize DataTable with modern settings
    $(document).ready(function() {
        $('.data-table').DataTable({
            paging: false,
            info: false,
            responsive: true,
            language: {
                search: "_INPUT_",
                searchPlaceholder: "Search records..."
            },
            columnDefs: [{
                orderable: false,
                targets: "no-sort"
            }]
        });
    });
    </script>
</body>
</html>