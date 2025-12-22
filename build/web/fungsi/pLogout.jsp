<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<%
        HttpSession sess = request.getSession();
    sess.removeAttribute("id_user");
    response.sendRedirect("../login.jsp");
    %>