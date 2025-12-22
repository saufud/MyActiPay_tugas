<%@ include file="fungsi/koneksi.jsp" %>
    <%@ page import="java.sql.*" %>
<%@ include file="partisi/head.jsp" %>

<body>

<%@ include file="partisi/navbar.jsp" %>
 <%
     String id_kegiatan = request.getParameter("id");
     PreparedStatement stmt = null;
    ResultSet rs = null;    
    String sql = "SELECT * FROM kegiatan WHERE id=?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, id_kegiatan);
    rs = stmt.executeQuery();
    rs.next();
          %>
          <%
    String nim = session.getAttribute("nim").toString();
    PreparedStatement st = conn.prepareStatement(
        "SELECT " +
        "   k.target_kas, " +
        "   IFNULL(SUM(p.jumlah_bayar), 0) AS total_bayar, " +
        "   (k.target_kas - IFNULL(SUM(p.jumlah_bayar), 0)) AS sisa_bayar, " +
        "   CASE WHEN IFNULL(SUM(p.jumlah_bayar),0) >= k.target_kas " +
        "        THEN 'lunas' ELSE 'belum' END AS status_lunas " +
        "FROM kegiatan k " +
        "LEFT JOIN pembayaran p ON k.id = p.id_kegiatan AND p.nim = ? AND p.status = 'diterima' " +
        "WHERE k.id = ?"
    );
    st.setString(1, nim);
    st.setString(2, id_kegiatan);

    ResultSet rr = st.executeQuery();
    rr.next();

    int target = rr.getInt("target_kas");
    int total = rr.getInt("total_bayar");
    int sisa = rr.getInt("sisa_bayar");
    String status = rr.getString("status_lunas");
    

%>
<div class="container mt-5" style="padding-top: 2rem;">
 <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "Pembayaran_field":
        %>
                    <script>
                        Swal.fire('peringatan!', 'pembayaran gagal!', 'warning');
                    </script>
        <%
                    break;
                case "Pembayaran_success":
        %>
                <script>
                    Swal.fire('berhasil!', 'pembayaran berhasil di bayarkan', 'success');
                </script>
        <%
            }
            // hapus session alert
            session.removeAttribute("alert");
        }
        %>
    <div class="card p-4 mb-4">
        <h4 class="fw-semibold mb-1">
            Kegiatan: <span class="text-primary"><%= rs.getString("nama_kegiatan") %></span>
        </h4>
        
        <p class="text-muted mb-0">Target iuran: <%= rs.getString("target_kas") %></p>
        <p class="text-muted mb-0">Sudah dibayar: <span class="text-success fw-bold">Rp <%= total %></span></p>
        <p class="text-muted">Sisa bayar: 
            <span class="text-danger fw-bold">Rp <%= sisa %></span>
        </p>
    </div>

    <!-- Form Bayar -->
    <div class="card p-4 mb-4">
        <h5 class="d-flex align-items-center fw-semibold mb-3"><span class="material-symbols-outlined">
payments
</span> Pembayaran</h5>

        <form action="fungsi/pPembayaran.jsp" method="POST">

    <input type="hidden" name="id_kegiatan" value="<%= id_kegiatan %>">
    <% if (status.equals("lunas")) { %>
       <div class="row g-3">
    <div class="col-md-6">
        <label class="form-label disabled">Jumlah Bayar (Rp)</label>
        <input type="number" class="form-control" name="jumlah_bayar" placeholder="50000" min="1000" max="75000 required disabled>
    </div>
</div>

<div class="mt-3 text-end">
    <button type="submit" class="btn btn-success" disabled>
       LUNAS 
    </button>
</div>
            <% } else { %>
             <div class="row g-3">
        <div class="col-md-6">
            <label class="form-label">Jumlah Bayar (Rp)</label>
            <input type="number" class="form-control" name="jumlah_bayar" placeholder="50000" min="1000" required>
        </div>
    </div>

    <div class="mt-3 text-end">
        <button type="submit" class="btn btn-success">Kirim Pembayaran</button>
    </div>
               

    <% } %>
    
</form>

    </div>


<div class="card p-3 mb-4 shadow-sm">
    <h5 class="fw-semibold mb-3">Status Pembayaran</h5>

    <table class="table table-bordered text-center align-middle">
        <thead class="table-dark">
            <tr>
                <th>Target</th>
                <th>Total Bayar</th>
                <th>Sisa</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>Rp <%= target %></td>
                <td class="text-success fw-bold">Rp <%= total %></td>
                <td class="text-danger fw-bold">Rp <%= sisa %></td>
                <td>
                    <% if (status.equals("lunas")) { %>
                        <span class="badge bg-success px-3 py-2">Lunas</span>
                    <% } else { %>
                        <span class="badge bg-warning text-dark px-3 py-2">Belum Lunas</span>
                    <% } %>
                </td>
            </tr>
        </tbody>
    </table>
</div>


</div>

<%@ include file="partisi/fother.jsp" %>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
