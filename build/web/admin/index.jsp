<%@ include file="../fungsi/koneksi.jsp" %>

<%@ include file="../partisi/head.jsp" %>
  <!-- Navbar -->
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
                case "add_kegiatan_success":
    %>
                <script>
                    Swal.fire('berhasil!', 'kegiatan berhasil di tambahkan', 'success');
                </script>
    <%
                    break;
                case "deleted_success":
    %>
                <script>
                    Swal.fire('berhasil!', 'kegiatan berhasil di hapus', 'success');
                </script>
                <% 
                    break;
                    case "deleted_field":
        %>
                    <script>
                        Swal.fire('peringatan!', 'status masih aktif tidak bisa di hapus!', 'warning');
                    </script>
        <%                
    
            }

            // hapus session alert
            session.removeAttribute("alert");
        }
    %>


  <div class="container mt-5"  style="padding-top: 2rem;">
      <a href="add_kegiatan.jsp" class="btn btn-sm btn-primary mb-4 fs-6 fw-bold">tambah kegiatan + </a>
    <!-- Daftar Kegiatan -->
      <h5 class="fw-semibold mb-3">Daftar Kegiatan Kas</h5>
      <div class="row">
          <%
            String sql = "SELECT * FROM kegiatan";
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            
          %>

          
      <div class="card shadow-lg border-0 p-4" style="border-radius: 16px;">
    <h4 class="fw-bold mb-3">Daftar Kegiatan</h4>

    <div class="table-responsive">
        <table class="table table-hover align-middle">
            <thead class="table-dark">
                <tr>
                    <th style="width: 50px;">No</th>
                    <th style="width: 90px;">Gambar</th>
                    <th>Nama Kegiatan</th>
                    <th>Target Kas</th>
                    <th>Periode</th>
                    <th>Status</th>
                    <th style="width: 230px;">Aksi</th>
                </tr>
            </thead>

            <tbody class="table-group-divider">
                <%
                    int no = 1;

                    while (rs.next()) {
                        String B_colour = "";
            String status = rs.getString("status");
            switch(status){
                case "aktif":
                     B_colour = "success";
                    break;
                case "selesai":
                     B_colour = "danger";
                    break;
            }
                        
                %>

                <tr class="hover-row">
                    <td class="fw-bold"><%= no++ %></td>

                    <!-- Thumbnail -->
                    <td>
                        <img src="../img/gambar_kegiatan/<%= rs.getString("gambar") %>"
                             style="width:70px; height:55px; object-fit:cover; border-radius:8px;">
                    </td>

                    <!-- Nama kegiatan -->
                    <td class="fw-semibold fs-6">
                        <%= rs.getString("nama_kegiatan") %>
                        <br>
                        <small class="text-muted">ID: <%= rs.getString("id") %></small>
                    </td>

                    <!-- Target Kas -->
                    <td class="text-primary fw-bold">
                        Rp <%= String.format("%,d", Integer.parseInt(rs.getString("target_kas"))).replace(",", ".") %>
                    </td>

                    <!-- Periode -->
                    <td class="text-muted">
                        <span class="fw-semibold"><%= rs.getString("tanggal_mulai") %></span>
                        <span class="text-primary fw-bold"> - </span>
                        <span class="fw-semibold"><%= rs.getString("tanggal_akhir") %></span>
                    </td>

                    <!-- Status badge -->
                    <td>
                        <span class="badge rounded-pill bg-<%= B_colour %> px-3 py-2 text-capitalize">
                            <%= status %>
                        </span>
                    </td>

                    <!-- Action Buttons -->
                    <td>
                        <a href="detail_kegiatan.jsp?id=<%= rs.getString("id") %>" 
                           class="btn btn-primary btn-sm me-1 d-inline-flex  align-items-center">
                            Detail
                            <span class="material-symbols-outlined">more_vert</span>
                        </a>

                        <a  onclick="return confirmDeleted(event)" href="fungsi/pDeleted_kegiatan.jsp?id=<%= rs.getString("id") %>" class="btn btn-danger btn-sm d-inline-flex  align-items-center">
                            Hapus<span class="material-symbols-outlined">delete</span> 
                        </a>
                    </td>
                </tr>

                <% } %>
            </tbody>
        </table>
    </div>
</div>
      </div>

    </div>

 <script>
     
    function confirmDeleted(e) {
        e.preventDefault();

        const url = e.currentTarget.href;

        Swal.fire({
            title: "Yakin Hapus?",
            text: "Anda akan menghapus kegiatan ini.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Ya, Hapus",
            cancelButtonText: "Batal"
        }).then((result) => {
            if (result.isConfirmed) {
                window.location = url;
            }
        });
    }

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
    
  <%@ include file="../partisi/fother.jsp" %>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
