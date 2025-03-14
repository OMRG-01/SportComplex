<%@page import="in.co.turf.booking.ctl.ManageTurfListCtl"%>
<%@page import="in.co.turf.booking.bean.ManageTurfBean"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Turf Slot Management</title>
<style>
:root {
    --primary-color: #2ecc71;
    --secondary-color: #27ae60;
    --accent-color: #f39c12;
    --dark-color: #2c3e50;
    --light-color: #ffffff;
    --text-color: #2c3e50;
    --bg-color: #f8f9fa;
}

body.dark-mode {
    --text-color: #ecf0f1;
    --bg-color: #2c3e50;
    --dark-color: #34495e;
}

.slot-container {
    padding: 2rem 1rem;
    margin: 0 auto;
    background: var(--bg-color);
    min-height: 100vh;
    background: linear-gradient(rgba(0,0,0,0.6), rgba(0,0,0,0.6)),
                        url('<%=TRBView.APP_CONTEXT%>/image/cricket2.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;

}
.slot{
     padding: 2rem 1rem;
        max-width: 1400px;
        margin: 0 auto;
        background: var(--bg-color);
        min-height: 100vh;

    border-radius: 15px;
}

.slot-header {
    background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
    color: white;
    padding: 1rem;
    border-radius: 15px;
    margin-bottom: 2rem;
    align-text:center;
}

.slot-table {
    background: var(--light-color);
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}

.slot-table table {
    margin-bottom: 0;
}

.status-available {
    color: var(--primary-color);
    font-weight: bold;
}

.status-booked {
    color: #e74c3c;
    font-weight: bold;
}

.action-buttons .btn {
    min-width: 80px;
    margin: 0 5px;
}

.search-card {
    background: var(--light-color);
    border-radius: 12px;
    padding: 1.5rem;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    margin-bottom: 2rem;
}

@media (max-width: 768px) {
    .slot-table {
        overflow-x: auto;
    }

    .table-responsive {
        -webkit-overflow-scrolling: touch;
    }
}

/* Dark mode adjustments */
body.dark-mode .slot-table {
    background: var(--dark-color);
    color: var(--light-color);
}

body.dark-mode .table-striped tbody tr:nth-of-type(odd) {
    background-color: rgba(255,255,255,0.05);
}

body.dark-mode .table-hover tbody tr:hover {
    background-color: rgba(255,255,255,0.1);
}
</style>
</head>
<body>
<%@ include file="Header.jsp"%>

<div class="slot-container">
    <div class="slot">
    <div class="slot-header">
        <h1 class="display-5 mb-4">
            <% if(userBean.getRoleId()==1){ %>
            Manage Turf Slots
            <% } else { %>
            Available Slots
            <% } %>
        </h1>

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
    </div>

    <div class="search-card">
        <form action="<%=TRBView.MANAGE_TURF_LIST_CTL%>" method="post">
            <div class="row g-3 align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-search"></i></span>
                        <input type="text" class="form-control" placeholder="Search by Turf Name"
                               name="name" value="<%=ServletUtility.getParameter("name", request)%>">
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="submit" name="operation" value="<%=ManageTurfListCtl.OP_SEARCH%>"
                                class="btn btn-primary me-md-2">
                            <i class="fas fa-search me-2"></i>Search
                        </button>
                        <button type="submit" name="operation" value="<%=ManageTurfListCtl.OP_RESET%>"
                                class="btn btn-outline-secondary">
                            Reset
                        </button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="slot-table">
        <div class="table-responsive">
            <table class="table table-striped table-hover align-middle">
                <thead class="table-primary">
                    <tr>
                        <% if(userBean.getRoleId()==1){ %>
                        <th style="width: 50px;">
                            <input type="checkbox" id="selectall" class="form-check-input">
                        </th>
                        <%} %>
                        <th>#</th>
                        <th>Turf Name</th>
                        <th>Time Slot</th>
                        <th>Price</th>
                        <th>Status</th>
                        <% if(userBean.getRoleId()==1){ %>
                        <th>Actions</th>
                        <%} %>
                    </tr>
                </thead>
                <tbody>
                    <%
                    int pageNo = ServletUtility.getPageNo(request);
                    int pageSize = ServletUtility.getPageSize(request);
                    int index = ((pageNo - 1) * pageSize) + 1;
                    int size = ServletUtility.getSize(request);
                    List list = ServletUtility.getList(request);
                    Iterator<ManageTurfBean> iterator = list.iterator();
                    while (iterator.hasNext()) {
                        ManageTurfBean bean = iterator.next();
                    %>
                    <tr>
                        <% if(userBean.getRoleId()==1){ %>
                        <td><input type="checkbox" class="case form-check-input" name="ids" value="<%=bean.getId()%>"></td>
                        <%} %>
                        <td><%=index++%></td>
                        <td><strong><%=bean.getTurfName()%></strong></td>
                        <td><%=bean.getTime()%></td>
                        <td>₹<%=bean.getPrice()%></td>
                        <td>
                            <span class="<%= "status-".concat(bean.getStatus().equals("Available") ? "available" : "booked") %>">
                                <%=bean.getStatus()%>
                            </span>
                        </td>
                        <% if(userBean.getRoleId()==1){ %>
                        <td>
                            <a href="manageTurf?id=<%=bean.getId()%>" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                        </td>
                        <%} %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Pagination -->
    <nav aria-label="Page navigation" class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item <%= (pageNo == 1) ? "disabled" : "" %>">
                <button class="page-link" name="operation" value="<%=ManageTurfListCtl.OP_PREVIOUS%>">
                    &laquo; Previous
                </button>
            </li>

            <% if(userBean.getRoleId() == 1) { %>
            <li class="page-item">
                <button class="page-link" name="operation" value="<%=ManageTurfListCtl.OP_NEW%>">
                    <i class="fas fa-plus"></i> New Slot
                </button>
            </li>
            <li class="page-item">
                <button class="page-link text-danger" name="operation" value="<%=ManageTurfListCtl.OP_DELETE%>">
                    <i class="fas fa-trash"></i> Delete
                </button>
            </li>
            <% } %>

            <li class="page-item <%= ((list.size() < pageSize) || (size <= pageNo * pageSize)) ? "disabled" : "" %>">
                <button class="page-link" name="operation" value="<%=ManageTurfListCtl.OP_NEXT%>">
                    Next &raquo;
                </button>
            </li>
        </ul>
    </nav>
    </div>
</div>

<%@ include file="Footer.jsp"%>

<script>
// Initialize checkbox functionality
document.getElementById('selectall').addEventListener('click', function(e) {
    document.querySelectorAll('.case').forEach(checkbox => {
        checkbox.checked = e.target.checked;
    });
});

// Add hover effects
document.querySelectorAll('tr').forEach(row => {
    row.addEventListener('mouseenter', () => {
        row.style.transform = 'translateX(5px)';
        row.style.transition = 'transform 0.2s ease';
    });
    row.addEventListener('mouseleave', () => {
        row.style.transform = 'translateX(0)';
    });
});
</script>
</body>
</html>