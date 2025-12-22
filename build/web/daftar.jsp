<!DOCTYPE html>
<html lang="id">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>

    <!-- Bootstrap 5 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">
    <%
        // Alert menggunakan session
        String alert = (String) session.getAttribute("alert");

        if (alert != null) {

            switch (alert) {
                case "register_failed":
    %>
                    <script>
                        Swal.fire('Peringatan!', 'NIM tersebut sudah di gunakan', 'warning');
                    </script>
    <%
                    break;
            }

            // hapus session alert
            session.removeAttribute("alert");
        }
    %>
    <div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
        <div class="row bg-white shadow rounded-4 p-4" style="max-width: 850px;">

            <!-- BAGIAN KIRI (LOGO) -->
            <div class="col-md-6 d-flex justify-content-center align-items-center">
                <img src="img/logo-nav.png" alt="Logo" class="img-fluid" style="max-width: 90%;">
            </div>

            <div class="col-md-6 p-4">
                <h3 class="text-center mb-4 fw-bold">Daftar</h3>

                <form action="fungsi/pDaftar.jsp" method="POST" enctype="multipart/form-data">

                    <div class="mb-3">
                        <label class="form-label">NIM</label>
                        <input type="text" class="form-control" name="nim" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>

                    
                    <div class="mb-3">
                        <label class="form-label">No. Telepon</label>
                        <input type="text" class="form-control" name="no_telp">
                    </div>
                    
                    
                    
                    <div class="mb-3">
                        <label class="form-label">Jenis Kelamin</label>
                        <select class="form-select" name="jenis_kelamin">
                            <option value="Laki-laki">Laki-laki</option>
                            <option value="Perempuan">Perempuan</option>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Foto Profil</label>
                        <input type="file" class="form-control" name="profile">
                    </div>
                    <button class="btn btn-primary w-100" type="submit">Daftar</button>

                    <p class="text-center mt-3">
                        Sudah punya akun? <a href="login.jsp" class="text-primary">Masuk</a>
                    </p>

                </form>
            </div>

        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>
