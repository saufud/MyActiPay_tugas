<%@ page import="java.sql.*" %>
<%@ include file="../../fungsi/koneksi.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String nama = request.getParameter("nama_kegiatan");
    String target_kas = request.getParameter("target_kas");
    String tanggal_akhir = request.getParameter("tanggal_akhir");
    String status = request.getParameter("status");

    int targetKas = Integer.parseInt(target_kas);

    PreparedStatement stmt = conn.prepareStatement(
        "UPDATE kegiatan SET nama_kegiatan=?, target_kas=?, tanggal_akhir=?, status=? WHERE id=?"
    );

    stmt.setString(1, nama);
    stmt.setInt(2, targetKas);
    stmt.setString(3, tanggal_akhir);
    stmt.setString(4, status);
    stmt.setString(5, id);

    stmt.executeUpdate();

    session.setAttribute("alert", "Update_kegiatan_success");

    response.sendRedirect("../detail_kegiatan.jsp?id="+id);
%>
