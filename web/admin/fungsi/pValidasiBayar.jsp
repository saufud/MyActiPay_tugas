<%@ page import="java.sql.*" %>
<%@ include file="../../fungsi/koneksi.jsp" %>

<%
    HttpSession sess = request.getSession();
    String id_bayar = request.getParameter("id");
    String aksi = request.getParameter("aksi");  
    String id_kegiatan = request.getParameter("id_kegiatan");

    PreparedStatement stmt = conn.prepareStatement(
        "UPDATE pembayaran SET status=? WHERE id=?"
    );

    stmt.setString(1, aksi);
    stmt.setString(2, id_bayar);
    stmt.executeUpdate();
    sess.setAttribute("alert", "validasi_success");
    response.sendRedirect("../validasi_pembayaran.jsp?id=" + id_kegiatan);
%>
