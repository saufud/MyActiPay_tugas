<%@ include file="../partisi/head.jsp" %>
<!-- Navbar -->
<%@ include file="partisi/navbar.jsp" %>

<div class="pt-5">
    <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "gambar_field_format":
    %>
                    <script>
                        Swal.fire('gagal!', 'hanya bisa upload gambar', 'error');
                    </script>
    <%
                    break;
                case "gambar_field_sz":
%>
                <script>
                    Swal.fire('gagal!', 'gambar maksimal 1 mb', 'error');
                </script>
<%
            }

            // hapus session alert
            session.removeAttribute("alert");
        }
    %>
    <!-- Form Buat Kegiatan -->
    <div class="card p-4 w-50 mx-auto mb-4 pt-5 pb-5 mt-5 mx-5">
        <h5 class="fw-semibold mb-3">Tambah Kegiatan Kas</h5>

        <form action="fungsi/pAdd_kegiatan.jsp" method="POST" enctype="multipart/form-data">
            <div class="row g-4">

                <div class="">
                    <label class="form-label">Nama Kegiatan</label>
                    <input type="text" class="form-control" name="nama_kegiatan" placeholder="Misal: Jalan-Jalan" required>
                </div>

                <div class="">
                    <label class="form-label">Target per Anggota (Rp)</label>
                    <input type="number" class="form-control" name="target_kas" placeholder="200000" required>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Tanggal akhir</label>
                    <input type="date" class="form-control" name="tgl_akhir" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Foto Profil</label>
                    <input type="file" class="form-control" name="profile">
                </div>

            </div>

            <div class="mt-3 text-end">
                <button class="btn btn-primary">Simpan Kegiatan</button>
            </div>
        </form>

    </div>
</div>
<%@ include file="../partisi/fother.jsp" %>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
