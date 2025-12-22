<%@ page import="java.sql.*" %>
<%@ include file="fungsi/koneksi.jsp" %>
<%@ include file="partisi/head.jsp" %>
<%@ include file="partisi/navbar.jsp" %>

<%
    String nim = session.getAttribute("nim").toString();

    PreparedStatement st = conn.prepareStatement(
        "SELECT " +
        "   k.id, " +
        "   k.nama_kegiatan, " +
        "   k.target_kas, " +
        "   IFNULL(SUM(p.jumlah_bayar), 0) AS total_bayar, " +
        "   (k.target_kas - IFNULL(SUM(p.jumlah_bayar), 0)) AS sisa_bayar, " +
        "   CASE WHEN IFNULL(SUM(p.jumlah_bayar), 0) >= k.target_kas " +
        "        THEN 'lunas' ELSE 'belum lunas' END AS status_lunas " +
        "FROM kegiatan k " +
        "LEFT JOIN pembayaran p ON k.id = p.id_kegiatan " +
        "   AND p.nim = ? " +
        "   AND p.status = 'diterima' " +
        "GROUP BY k.id " +
        "ORDER BY k.id DESC"
    );

    st.setString(1, nim);
    ResultSet rs2 = st.executeQuery();
%>

<div class="container" style="margin-top: 5rem;" >
    <h4  class=" fw-semibold mb-4 d-flex align-items-center"><span class="material-symbols-outlined">
money_bag
</span>  Status Pembayaran Semua Kegiatan</h4>

    <table class="table table-bordered table-striped text-center align-middle shadow-sm">
        <thead class="table-dark">
            <tr>
                <th>No</th>
                <th>Nama Kegiatan</th>
                <th>Target</th>
                <th>Total Bayar</th>
                <th>Sisa</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                int no = 1;
                while (rs2.next()) {
            %>
            <tr>
                <td><%= no++ %></td>
                <td class="text-start"><%= rs2.getString("nama_kegiatan") %></td>
                <td>Rp <%= rs2.getInt("target_kas") %></td>
                <td class="text-success fw-bold">Rp <%= rs2.getInt("total_bayar") %></td>
                <td class="text-danger fw-bold">Rp <%= rs2.getInt("sisa_bayar") %></td>
                <td>
                    <% if (rs2.getString("status_lunas").equals("lunas")) { %>
                        <span class="badge bg-success px-3 py-2">Lunas</span>
                    <% } else { %>
                        <span class="badge bg-warning text-dark px-3 py-2">Belum Lunas</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
