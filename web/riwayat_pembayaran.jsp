<%@ page import="java.sql.*" %>
<%@ include file="fungsi/koneksi.jsp" %>
<%@ include file="partisi/head.jsp" %>
<%@ include file="partisi/navbar.jsp" %>
<div class="card p-4">
    <h4 class="fw-semibold mb-3">? Riwayat Pembayaran Saya</h4>

    <table class="table table-striped align-middle table-bordered">
        <thead class="table-dark">
            <tr>
                <th>No</th>
                <th>ID Pembayaran</th>
                <th>Tanggal Bayar</th>
                <th>Nama Kegiatan</th>
                <th>Jumlah</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>

            <%
                int no = 1;
                String nim = session.getAttribute("nim").toString();

                PreparedStatement stmt = conn.prepareStatement(
                    "SELECT p.id, p.tanggal_bayar, p.jumlah_bayar, p.status, k.nama_kegiatan AS nama_kegiatan " +
                    "FROM pembayaran p " +
                    "JOIN kegiatan k ON p.id_kegiatan = k.id " +
                    "WHERE p.nim=? " +
                    "ORDER BY p.tanggal_bayar DESC"
                );
                stmt.setString(1, nim);

                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
            %>

            <tr>
                <td><%= no++ %></td>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("tanggal_bayar") %></td>
                <td><%= rs.getString("nama_kegiatan") %></td>
                <td>Rp <%= rs.getInt("jumlah_bayar") %></td>
                <td>
                    <% String st = rs.getString("status"); %>

                    <% if (st.equals("menunggu")) { %>
                        <span class="badge bg-warning text-dark">Menunggu</span>
                    <% } else if (st.equals("diterima")) { %>
                        <span class="badge bg-success">Diterima</span>
                    <% } else { %>
                        <span class="badge bg-danger">Ditolak</span>
                    <% } %>

                </td>
            </tr>

            <% } %>

        </tbody>
    </table>
</div>
