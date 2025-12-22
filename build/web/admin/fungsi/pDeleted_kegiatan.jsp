<%@ include file="../../fungsi/koneksi.jsp" %>

<%
    HttpSession sess = request.getSession();

    // Ambil id dari parameter
    String id = request.getParameter("id");


    String sql = "SELECT status FROM kegiatan WHERE id=?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, id);
    ResultSet rs = stmt.executeQuery();

    if (!rs.next()) {
        sess.setAttribute("alert", "deleted_notfound");
        response.sendRedirect("../index.jsp");
        return;
    }

    String status = rs.getString("status");

    if ("aktif".equals(status)) {
        sess.setAttribute("alert", "deleted_field");
        response.sendRedirect("../index.jsp");
        return;
    }

    String sqlDel = "DELETE FROM kegiatan WHERE id=?";
    PreparedStatement del = conn.prepareStatement(sqlDel);
    del.setString(1, id);
    del.executeUpdate();

    sess.setAttribute("alert", "deleted_success");
    response.sendRedirect("../index.jsp");
%>
