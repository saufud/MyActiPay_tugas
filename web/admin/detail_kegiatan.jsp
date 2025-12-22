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
          %>
          
          <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "deleted_field":
        %>
                    <script>
                        Swal.fire('peringatan!', 'status masih aktif tidak bisa di hapus!', 'warning');
                    </script>
        <%
                    break;
                case "Update_kegiatan_success":
        %>
                <script>
                    Swal.fire('berhasil!', 'kegiatan berhasil di update', 'success');
                </script>
                <%
                    break;
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
  <div class="container mt-5"  style="padding-top: 2rem;">
      
    <!-- Info Kegiatan -->
    <div class="card p-4 mb-4">
    <img src="../img/gambar_kegiatan/<%= rs.getString("gambar") %>"
         class="card-img-top"
         style="width: 23rem;hight:23rem; object-fit: cover;">

    <div class="card-body">
        <h4 class="fw-semibold mb-1">
            Kegiatan: <span class="text-primary"><%= rs.getString("nama_kegiatan") %></span>
        </h4>
        <p class="text-muted mb-3">Target per anggota: Rp <%= rs.getString("target_kas") %></p>
        <span class="mb-3 badge rounded-pill bg-<%= B_colour %> px-3 py-2 text-capitalize"><%= statusK %></span> <br>
        <a href="edit_kegiatan.jsp?id=<%= rs.getString("id") %>" class="gap-2 btn btn-primary btn-sm d-inline-flex  align-items-center">
            <span class="material-symbols-outlined">edit</span> Edit
        </a>
        <a href="pembayaran_anggota.jsp?id=<%= rs.getString("id") %>" class="btn btn-primary gap-2 btn-sm d-inline-flex  align-items-center">
            <span class="material-symbols-outlined">payments</span> pembayaran anggota
        </a>
         <a href="validasi_pembayaran.jsp?id=<%= rs.getString("id") %>" class="btn btn-primary gap-2 btn-sm d-inline-flex  align-items-center">
            <span class="material-symbols-outlined">check_circle</span> validasi pembayaran
        </a>
        
    </div>
</div>

    </div>



    <a href="index.jsp" 
   class="btn btn-primary position-fixed bottom-0 start-0 m-4 shadow-lg d-inline-flex justify-content-center align-items-center">
    <i class="bi bi-arrow-left"></i> <span class="material-symbols-outlined">arrow_back</span>
</a>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <%@ include file="../partisi/fother.jsp" %>
</body>
</html>
