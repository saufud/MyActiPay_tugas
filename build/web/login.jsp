<%@ page import="javax.servlet.*, javax.servlet.http.*, javax.servlet.annotation.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login Page</title>

    <!-- Bootstrap 5 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<%
    // ALERT MENGGUNAKAN SESSION
    HttpSession sess = request.getSession();
    String alert = (String) sess.getAttribute("alert");

    if (alert != null) {

        switch (alert) {

            case "register_success":
%>
                <script>
                    Swal.fire('Berhasil!', 'akun berhasil di buat', 'success');
                </script>
<%
                break;

            case "register_failed":
%>
                <script>
                    Swal.fire('Gagal!', 'akun gagal di buat', 'error');
                </script>
<%
                break;
                case "login_failed":
    %>
                    <script>
                        Swal.fire('Gagal!', 'Username atau password salah', 'error');
                    </script>
    <%
                   
                    break;
        }

        // hapus setelah tampil
        sess.removeAttribute("alert");
    }
%>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh;">
    <div class="row shadow-lg rounded-4 overflow-hidden bg-white" style="max-width: 900px; width: 100%;">

        <!-- Bagian Gambar -->
        <div class="col-md-6 d-none d-md-block p-0">
            <img src="img/logo-nav.png" 
                 alt="Login Image" 
                 class="img-fluid h-100 w-100" 
                 style="object-fit: cover;">
        </div>

        <!-- Bagian Form Login -->
        <div class="col-md-6 p-5">
            <h3 class="mb-4 fw-bold text-center">Login</h3>

            <form action="fungsi/pLogin.jsp" method="POST">
                <div class="mb-3">
                    <label class="form-label">NIM</label>
                    <input name="nim" type="text" class="form-control" placeholder="Masukkan nim" required>
                </div>

                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input name="password" type="password" class="form-control" placeholder="Masukkan password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 mt-2">Masuk</button>

                <p class="text-center mt-3 mb-0">
                    Belum punya akun? <a href="daftar.jsp" class="text-decoration-none">Daftar</a>
                </p>
            </form>
        </div>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
