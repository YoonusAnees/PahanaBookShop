<%@ page import="com.pahana.bookshop.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"customer".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/index.jsp");
        return;
    }
%>
<h1>Welcome Customer: <%= user.getUsername() %></h1>
<a href="<%= request.getContextPath() %>/LogoutController">Logout</a>
