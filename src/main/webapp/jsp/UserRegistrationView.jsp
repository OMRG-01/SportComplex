<%@page import="in.co.turf.booking.util.HTMLUtility"%>
<%@page import="java.util.HashMap"%>
<%@page import="in.co.turf.booking.ctl.UserRegistrationCtl"%>
<%@page import="in.co.turf.booking.util.DataUtility"%>
<%@page import="in.co.turf.booking.util.ServletUtility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration - Turf Booking</title>
<style>
    :root {
        --primary-color: #2ecc71;
        --secondary-color: #27ae60;
        --accent-color: #f39c12;
        --dark-color: #2c3e50;
        --light-color: #ffffff;
    }
    .formc {
            display: block;
            width: 90%;
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
    .registration-container {
        display: flex;
        min-height: 100vh;
        align-items: center;
        justify-content: flex-end;
        background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        padding: 2rem 4rem;
        position: relative;
        overflow: hidden;
    }

    .registration-card {
        background: rgba(255, 255, 255, 0.95);
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0,0,0,0.1);
        width: 100%;
        max-width: 800px;
       padding: 2.5rem 4rem 2.5rem 2.5rem;
        margin-right: 2rem;
    }

    .registration-header {
        text-align: center;
        margin-bottom: 2rem;
    }

    .registration-title {
        font-size: 2rem;
        color: var(--dark-color);
        margin-bottom: 0.5rem;
        font-weight: 700;

    }

    .form-grid {
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 1.5rem;
        margin-bottom: 1.5rem;
    }

    .form-group {
        position: relative;
         margin-bottom: 1rem;
    }

    .input-icon {
        position: absolute;
        left: 1rem;
        top: 50%;
        transform: translateY(-50%);
        color: #666;
        z-index: 1;
    }

    .form-control {
        width: 100%;
        padding: 0.8rem 1rem 0.8rem 3rem;
        border: 2px solid #eee;
        border-radius: 8px;
        font-size: 1rem;
        transition: all 0.3s ease;
    }

    .form-control:focus {
        border-color: var(--primary-color);
        box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
    }

    .error-message {
        color: #e74c3c;
        font-size: 0.9rem;
        margin-top: 0.5rem;
        display: block;
    }

     .gender-select {
            position: relative;
            width: 100%;
            margin-top: 0.5rem;
            padding-left: 2.5rem;
        }

        .gender-select select {
            width: 100%;
           padding: 0.8rem;
                   font-size: 0.9rem;
            border: 2px solid #eee;
            border-radius: 8px;
            background-color: white;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            font-size: 1rem;
            color: #333;
            cursor: pointer;
            transition: all 0.3s ease;
            padding-left: 2.9rem;
        }

        .gender-select select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(46, 204, 113, 0.1);
            outline: none;
        }

        .gender-select::after {
            content: "\f078";
            font-family: "Font Awesome 5 Free";
            font-weight: 900;
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            pointer-events: none;
        }

        .gender-select:hover::after {
            color: var(--primary-color);
        }

        /* Style options */
        .gender-select option {
            padding: 1rem;
            background: white;
            color: #333;
        }

        .gender-select option:hover {
            background: var(--primary-color);
            color: white;
        }

    .file-upload {
        position: relative;
        overflow: hidden;
        display: inline-block;
    }

    .file-input {
        position: absolute;
        left: 0;
        top: 0;
        opacity: 0;
        cursor: pointer;
    }

    .file-label {
        padding: 0.75rem 1.5rem;
        background: var(--accent-color);
        color: white;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .file-label:hover {
        background: #e67e22;
    }

    .form-actions {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .primary-btn {
        background: var(--primary-color);
        color: white;
        padding: 1rem 2rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .secondary-btn {
        background: var(--accent-color);
        color: white;
        padding: 1rem 2rem;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .primary-btn:hover, .secondary-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }


    .background-slideshow {
        position: absolute;
        width: 100%;
        height: 100%;
        animation: slideshow 20s infinite;
        right:0;
    }

    .background-slideshow::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, rgba(0,0,0,0.6), rgba(0,0,0,0.3));
    }

    .bg-slide {
        position: absolute;
        width: 100%;
        height: 100%;
        opacity: 0;
        animation: fade 20s infinite;
        object-fit: cover;
    }

    .bg-slide:nth-child(1) { animation-delay: 0s; }
    .bg-slide:nth-child(2) { animation-delay: 5s; }
    .bg-slide:nth-child(3) { animation-delay: 10s; }
    .bg-slide:nth-child(4) { animation-delay: 15s; }

    @keyframes fade {
        25% { opacity: 1; }
        40% { opacity: 0; }
    }

    .registration-card {
        position: relative;
        z-index: 1;
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(5px);
    }
</style>
</head>
<body>
<%@ include file="Header.jsp"%>

<div class="registration-container">
    <div class="background-slideshow">
        <img src="<%=TRBView.APP_CONTEXT%>/image/cricket.jpg" class="bg-slide" alt="Football Turf">
        <img src="<%=TRBView.APP_CONTEXT%>/image/football-stadium.jpg" class="bg-slide" alt="Cricket Turf">
        <img src="<%=TRBView.APP_CONTEXT%>/image/cricketplay.jpeg" class="bg-slide" alt="Turf Events">
        <img src="<%=TRBView.APP_CONTEXT%>/image/badmenton.jpeg" class="bg-slide" alt="Turf Facilities">
    </div>
    <div class="registration-card">
        <div class="registration-header">
            <h1 class="registration-title">Create Account</h1>
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

        <form action="<%=TRBView.USER_REGISTRATION_CTL%>" method="post">
            <jsp:useBean id="bean" class="in.co.turf.booking.bean.UserBean" scope="request"></jsp:useBean>

            <input type="hidden" name="id" value="<%=bean.getId()%>">
            <!-- Other hidden fields here -->

            <div class="form-grid">
                <div class="form-group">
                    <i class="fas fa-user input-icon"></i>
                    <input type="text" class="formc" name="name"
                           value="<%=DataUtility.getStringData(bean.getName())%>"
                           placeholder="Full Name" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("name", request)%>
                    </span>
                </div>

                <div class="form-group">
                    <i class="fas fa-at input-icon"></i>
                    <input type="text" class="formc" name="userName"
                           value="<%=DataUtility.getStringData(bean.getUserName())%>"
                           placeholder="Username" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("userName", request)%>
                    </span>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="formc" name="password"
                           placeholder="Password" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("password", request)%>
                    </span>
                </div>

                <div class="form-group">
                    <i class="fas fa-lock input-icon"></i>
                    <input type="password" class="formc" name="confirmPassword"
                           placeholder="Confirm Password" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("confirmPassword", request)%>
                    </span>
                </div>
            </div>

            <div class="form-grid">
                <div class="form-group">
                    <i class="fas fa-envelope input-icon"></i>
                    <input type="email" class="formc" name="emailId"
                           value="<%=DataUtility.getStringData(bean.getEmailId())%>"
                           placeholder="Email Address" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("emailId", request)%>
                    </span>
                </div>

                <div class="form-group">
                    <i class="fas fa-mobile-alt input-icon"></i>
                    <input type="tel" class="formc" name="mobile"
                           value="<%=DataUtility.getStringData(bean.getMobileNo())%>"
                           placeholder="Mobile Number" required>
                    <span class="error-message">
                        <%=ServletUtility.getErrorMessage("mobile", request)%>
                    </span>
                </div>
            </div>

            <div class="form-group">
                            <div class="form-grid">
                                    <i class="fas fa-venus-mars input-icon"></i>
                                    <div class="gender-wrapper">
                                        <div class="gender-select">
                                            <% HashMap<String, String> map = new HashMap<>();
                                            map.put("Male", "Male");
                                            map.put("Female", "Female");%>
                                            <%=HTMLUtility.getList("gender", String.valueOf(bean.getGender()), map)%>

                                        </div>
                                        <span class="error-message">
                                            <%=ServletUtility.getErrorMessage("gender", request)%>
                                        </span>
                                    </div>

                            </div>
                        </div>


            <div class="form-group">
                <i class="fas fa-map-marker-alt input-icon"></i>
                <textarea class="formc" rows="3" name="address"
                          placeholder="Address"><%=DataUtility.getStringData(bean.getAddress())%></textarea>
                <span class="error-message">
                    <%=ServletUtility.getErrorMessage("address", request)%>
                </span>
            </div>

            <div class="form-group">
                <div class="file-upload">
                    <input type="file" class="file-input" id="fileInput">
                    <label for="fileInput" class="file-label">
                        <i class="fas fa-cloud-upload-alt"></i> Upload Profile Picture
                    </label>
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" name="operation"
                        value="<%=UserRegistrationCtl.OP_SIGN_UP%>"
                        class="primary-btn">
                    Create Account
                </button>
                <button type="reset" class="secondary-btn">
                    Reset
                </button>
            </div>
        </form>
    </div>
</div>

<%@ include file="Footer.jsp"%>

<script>
    // File input display
    document.querySelector('.file-input').addEventListener('change', function(e) {
        const fileName = e.target.files[0].name;
        document.querySelector('.file-label').textContent = fileName;
    });
</script>
</body>
</html>