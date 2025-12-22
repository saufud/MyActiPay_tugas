<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../fungsi/koneksi.jsp" %>
<%@ include file="../partisi/head.jsp" %>
  <!-- Navbar -->
<%@ include file="partisi/navbar.jsp" %>
     <%
     String id = request.getParameter("id");
     PreparedStatement stmt = null;
    ResultSet rs = null;    
    String sql = "SELECT * FROM kegiatan WHERE id=?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, id);
    rs = stmt.executeQuery();
    rs.next();
    
    String B_colour = "";
            String statusK = rs.getString("status");
            switch(statusK){
                case "aktif":
                     B_colour = "success";
                    break;
                case "selesai":
                     B_colour = "danger";
                    break;
            }
    
    stmt = conn.prepareStatement(
        "SELECT p.id AS id_bayar, p.tanggal_bayar, p.jumlah_bayar, p.status, " +
        "u.username AS nama_user " +
        "FROM pembayaran p " +
        "JOIN users u ON p.nim = u.nim " +
        "WHERE p.id_kegiatan=? ORDER BY p.tanggal_bayar DESC"
    );
    stmt.setString(1, id);
    ResultSet rsv = stmt.executeQuery();
          %>
          <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "validasi_success":
        %>
                <script>
                    Swal.fire('berhasil!', 'pembayaran berhasil di validasi', 'success');
                </script>
        <%
            }
            // hapus session alert
            session.removeAttribute("alert");
        }
        %>
    <h5 class="fw-bold mb-3 text-center" style="margin-top: 5rem">Validasi Pembayaran || <%= rs.getNString("nama_kegiatan") %></h5>
    <div class="card p-4">

    <table class="table table-striped align-middle table-bordered">
        <thead class="table-dark">
            <tr>
                <th>No</th>
                <th>Nama</th>
                <th>Tanggal</th>
                <th>Jumlah</th>
                <th>Status Validasi</th>
                <th>Aksi</th>
            </tr>
        </thead>

        <tbody>
            <%
                int noV = 1;
                while (rsv.next()) {
            %>
            <tr>
                <td><%= noV++ %></td>
                <td><%= rsv.getString("nama_user") %></td>
                <td><%= rsv.getString("tanggal_bayar") %></td>
                <td>Rp <%= String.format("%,d", rsv.getInt("jumlah_bayar")).replace(",", ".") %></td>

                <td>
                    <% String st = rsv.getString("status"); %>

                    <% if (st.equals("diterima")) { %>
                        <span class="badge bg-success">Diterima</span>

                    <% } else if (st.equals("menunggu")) { %>
                        <span class="badge bg-warning text-dark">Menunggu</span>

                    <% } else { %>
                        <span class="badge bg-danger">Ditolak</span>
                    <% } %>
                </td>

                <td>
                    <% if (st.equals("menunggu")) { %>
                        
                        <!-- Tombol Terima -->
                        <a href="fungsi/pValidasiBayar.jsp?id=<%= rsv.getString("id_bayar") %>&aksi=diterima&id_kegiatan=<%= id %>"
                           class="btn btn-success btn-sm me-2">
                            Terima
                        </a>

                        <!-- Tombol Tolak -->
                        <a href="fungsi/pValidasiBayar.jsp?id=<%= rsv.getString("id_bayar") %>&aksi=ditolak&id_kegiatan=<%= id %>"
                           class="btn btn-danger btn-sm">
                            Tolak
                        </a>

                    <% } else { %>
                        <span class="badge bg-secondary d-inline-flex  align-items-center gap-2"><span class="material-symbols-outlined">check_circle</span> Diverifikasi</span>
                    <% } %>
                </td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>
            <a href="detail_kegiatan.jsp?id=<%= id %>" 
   class="btn btn-primary position-fixed bottom-0 start-0 m-4 shadow-lg d-inline-flex justify-content-center align-items-center">
    <i class="bi bi-arrow-left"></i> <span class="material-symbols-outlined">arrow_back</span>
</a>