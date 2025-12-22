<%@ page import="java.sql.*" %>
<%@ include file="koneksi.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    String nim = session.getAttribute("nim").toString();
    String id_kegiatan = request.getParameter("id_kegiatan");
    String jumlah_bayar = request.getParameter("jumlah_bayar");

    // Generate ID pembayaran
    String id = "BYR" + System.currentTimeMillis();

    String status = "menunggu";

    PreparedStatement stmt = conn.prepareStatement(
        "INSERT INTO pembayaran (id, nim, id_kegiatan, tanggal_bayar, jumlah_bayar, status) VALUES (?, ?, ?, NOW(), ?, ?)"
    );

    stmt.setString(1, id);
    stmt.setString(2, nim);
    stmt.setString(3, id_kegiatan);
    stmt.setString(4, jumlah_bayar);
    stmt.setString(5, status);

    int hasil = stmt.executeUpdate();

    if (hasil > 0) {
        session.setAttribute("alert", "Pembayaran_success");
    } else {
        session.setAttribute("alert", "Pembayaran_field");
    }

    response.sendRedirect("../pembayaran.jsp?id=" + id_kegiatan);
%>
