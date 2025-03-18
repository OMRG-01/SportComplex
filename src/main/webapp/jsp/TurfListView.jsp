<%@page import="in.co.turf.booking.bean.TurfBean"%>
<%@page import="in.co.turf.booking.ctl.TurfListCtl"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Turf List</title>
<style>
.turf-list-container {
    padding: 2rem 1rem;

    margin: 0 auto;
     background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                    url('<%=TRBView.APP_CONTEXT%>/image/football-stadium.jpg');
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
        position: relative;

}
.turf-list{
    padding: 2rem 1rem;
    max-width:1400px;
        margin: 0 auto;
}

.search-section {
    background: var(--light-color);
    padding: 2rem;
    border-radius: 15px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

.turf-card {
    transition: all 0.3s ease;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    background: rgba(255,255,255,0.9) !important;
        backdrop-filter: blur(5px);

}

.turf-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 25px rgba(0,0,0,0.15);
}

.turf-image {
    height: 200px;
    object-fit: cover;
    transition: transform 0.3s ease;
}

.turf-image:hover {
    transform: scale(1.05);
}

.action-buttons .btn {
    margin: 0 5px;
    min-width: 80px;
}

.breadcrumb {
    background: rgba(var(--primary-rgb), 0.1);
    border-radius: 8px;
    padding: 1rem;
}

.filter-section {
    margin-bottom: 1.5rem;
}

.turf-features {
    display: flex;
    gap: 1rem;
    flex-wrap: wrap;
    margin: 1rem 0;
}

.turf-feature {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    background: rgba(var(--primary-rgb), 0.1);
    padding: 0.5rem 1rem;
    border-radius: 20px;
    font-size: 0.9rem;
}

@media (max-width: 768px) {
    .turf-card {
        margin-bottom: 1.5rem;
    }
    
    .search-section .row > div {
        margin-bottom: 1rem;
    }
}

/* Dark mode adjustments */

body.dark-mode .turf-card {
    background: rgba(0,0,0,0.7) !important;
    color: #ffffff;
}
body.dark-mode .search-section {
    background: #2c3e50;
}
</style>
</head>
<body>
<%@ include file="Header.jsp"%>

<div class="turf-list-container">

    <div class="turf-list">
    <div class="search-section">
        <h2 class="mb-4">Find Your Perfect Turf</h2>
        <form action="<%=TRBView.TURF_LIST_CTL%>" method="post">
            <div class="row g-3">
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" placeholder="Search by Name" 
                               name="name" value="<%=ServletUtility.getParameter("name", request)%>">
                    </div>
                </div>
                <div class="col-md-5">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-map-marker-alt"></i></span>
                        <input type="text" class="form-control" placeholder="Search by Location" 
                               name="location" value="<%=ServletUtility.getParameter("location", request)%>">
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="d-grid gap-2">
                        <button type="submit" name="operation" value="<%=TurfListCtl.OP_SEARCH%>" 
                                class="btn btn-primary">Search</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

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
    <%
    int pageNo = ServletUtility.getPageNo(request);
    int pageSize = ServletUtility.getPageSize(request);
    int size = ServletUtility.getSize(request);
    %>

    <div class="row">
        <% 
        List list = ServletUtility.getList(request);
        Iterator<TurfBean> iterator = list.iterator();
        while (iterator.hasNext()) {
            TurfBean bean = iterator.next();
        %>
        <div class="col-md-6 col-lg-4 mb-4">
            <div class="card turf-card">
                <img src="<%=TRBView.APP_CONTEXT%>/image/<%=bean.getImage()%>" 
                     class="card-img-top turf-image" alt="<%=bean.getName()%>">
                <div class="card-body">
                    <h5 class="card-title"><%=bean.getName()%></h5>
                    <p class="card-text text-muted"><i class="fas fa-map-marker-alt"></i> <%=bean.getLocation()%></p>
                    <div class="turf-features">
                        <div class="turf-feature">
                            <i class="fas fa-clock"></i> 24/7 Available
                        </div>
                        <div class="turf-feature">

                        </div>
                    </div>
                    <p class="card-text"><%=bean.getDescription()%></p>
                    <div class="action-buttons">
                        <% if(userBean.getRoleId() == 1) { %>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button" 
                                    data-bs-toggle="dropdown" aria-expanded="false">
                                Manage
                            </button>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="turf?id=<%=bean.getId()%>">Edit</a></li>
                                <li><a class="dropdown-item text-danger" href="#">Delete</a></li>
                            </ul>
                        </div>
                        <% } else { %>
                       <a href="<%=TRBView.BOOKING_CTL%>?turfId=<%=bean.getId()%>" class="btn btn-primary">
                           Book Now <i class="fas fa-arrow-right"></i>
                       </a>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <!-- Pagination -->
    <nav aria-label="Page navigation">
        <ul class="pagination justify-content-center">
                <li class="page-item <%= (pageNo == 1) ? "disabled" : "" %>">
                    <button class="page-link" name="operation"
                            value="<%=TurfListCtl.OP_PREVIOUS%>"
                            <%= (pageNo == 1) ? "disabled" : "" %>>
                        Previous
                    </button>
                </li>
            <% if(userBean.getRoleId() == 1) { %>
                    <li class="page-item">
                        <button class="page-link" name="operation"
                                value="<%=TurfListCtl.OP_NEW%>">
                            Add New Turf
                        </button>
                    </li>
            <% } %>
            <li class="page-item <%= ((list.size() < pageSize) || (size <= pageNo * pageSize)) ? "disabled" : "" %>">
                    <button class="page-link" name="operation"
                            value="<%=TurfListCtl.OP_NEXT%>"
                            <%= ((list.size() < pageSize) || (size <= pageNo * pageSize)) ? "disabled" : "" %>>
                        Next
                    </button>
                </li>
        </ul>
    </nav>
    </div>
</div>

<%@ include file="Footer.jsp"%>

<script>
// Initialize image hover effects
document.querySelectorAll('.turf-image').forEach(img => {
    img.addEventListener('mouseenter', () => {
        img.style.transform = 'scale(1.05)';
    });
    img.addEventListener('mouseleave', () => {
        img.style.transform = 'scale(1)';
    });
});

// Initialize tooltips
var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl);
});

// Form submission handling
document.querySelector('form').addEventListener('submit', function(e) {
    document.getElementById('loading-spinner').classList.remove('d-none');
});
</script>
</body>
</html>