<%@ include file="fungsi/koneksi.jsp" %>

<%
    // Cek login
    if (session.getAttribute("id_user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ResultSet rs = null;
    try {
        Integer idUser = (Integer) session.getAttribute("id_user");
        PreparedStatement stmt = null;
        String sqlU = "SELECT * FROM users WHERE id = ?";
        stmt = conn.prepareStatement(sqlU);
        stmt.setInt(1, idUser);
        rs = stmt.executeQuery();
        rs.next();
        

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>

<%@ include file="partisi/head.jsp" %>

<body>

    <%@ include file="partisi/navbar.jsp" %>

    <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "login_success":
    %>
                    <script>
                        Swal.fire('Berhasil!', 'Anda berhasil Login', 'success');
                    </script>
    <%
                    break;
            }

            // hapus session alert
            session.removeAttribute("alert");
        }
    %>

    <div class="container mt-5" style="padding-top: 2rem;">

        <!-- Info Profil -->
        <div class="card p-3 mb-4 d-flex flex-row gap-3 align-items-center">
            <img src="img/profile/<%= rs.getString("profil") %>" 
                 class="rounded-circle" width="50" height="50" alt="profil">
            <div>
                <h5 class="fw-semibold mb-1">
                    Nama: <span class="text-primary"><%= rs.getString("username") %></span>
                </h5>
                <p class="text-muted mb-0">
                    Nim: <%= rs.getString("nim") %>
                </p>
                <a href="detail_akun.jsp" class="btn btn-sm btn-info mt-2">Detail Akun</a>
            </div>
        </div>

        <!-- Daftar Kegiatan Kas -->
        <h5 class="fw-semibold mb-4 mt-5 text-center ">Daftar Kegiatan Kas</h5>
      
<!--        <div class="card p-4 mb-4">
            
        </div>-->
<div class="row">
          <%
            String sqlK = "SELECT * FROM kegiatan";
            Statement stK = conn.createStatement();
            ResultSet rsK = stK.executeQuery(sqlK);

            while(rsK.next()){
          %>
          <% 
              String B_colour = "";
            String status = rsK.getString("status");
            switch(status){
                case "aktif":
                     B_colour = "success";
                    break;
                case "selesai":
                     B_colour = "danger";
                    break;
            }
          %>
      <div class="col-md-4 mb-4">
    <div class="card shadow border-0" style="border-radius: 15px; overflow: hidden; ">

        <img src="img/gambar_kegiatan/<%= rsK.getString("gambar") %>"
             class="card-img-top" 
             style="height: 160px; object-fit: cover;">

        <div class="card-body">
            
            <h5 class="fw-bold mb-1"><%= rsK.getString("nama_kegiatan") %></h5>
            <p><%= rsK.getString("id") %></p>

            <p class="mb-1 text-muted">
                Target per anggota: <b><%= rsK.getString("target_kas") %></b>
            </p>
            <p class="mb-1 text-muted fs-6">
                Priode <b><%= rsK.getString("tanggal_mulai") %><span class="text-primary"> s/d </span><%= rsK.getString("tanggal_akhir") %></b>
            </p>

            <span class="badge bg-<%= B_colour %> px-3 py-2"><%= rsK.getString("status") %></span>

            <div class="mt-3 text-end">
                <a href="pembayaran.jsp?id=<%= rsK.getString("id") %>"
                   class="btn btn-primary btn-sm">
                    Lihat Detail
                </a>
            </div>

        </div>
    </div>
</div>
            <% } %>
      </div>
    </div>

    <script>
        function confirmLogout(e) {
            e.preventDefault();

            Swal.fire({
                title: "Logout sekarang?",
                text: "Anda akan keluar dari sesi ini.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Ya, Logout",
                cancelButtonText: "Batal"
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        position: "top",
                        icon: "success",
                        title: "anda telah berhasil logout",
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        window.location = e.target.href;
                    });
                }
            });

            return false;
        }
    </script>

    <%@ include file="partisi/fother.jsp" %>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
<!--<div>
<h5 class="fw-semibold mb-3">Kegiatan Kas Kelas</h5>
            <table class="table table-striped align-middle">
                <thead>
                    <tr>
                        <th>No</th>
                        <th>Kegiatan</th>
                        <th>Target</th>
                        <th>Sudah Bayar</th>
                        <th>Status</th>
                        <th>Aksi</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Jalan-Jalan ke Pantai</td>
                        <td>Rp 200.000</td>
                        <td>Rp 125.000</td>
                        <td><span class="badge bg-warning text-dark">Belum Lunas</span></td>
                        <td><a href="bayar.jsp" class="btn btn-sm btn-info">Lihat Detail</a></td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Buka Bersama</td>
                        <td>Rp 100.000</td>
                        <td>Rp 100.000</td>
                        <td><span class="badge bg-success">Lunas</span></td>
                        <td><a class="btn btn-sm btn-info">Lihat Detail</a></td>
                    </tr>
                </tbody>
            </table>
</div>-->