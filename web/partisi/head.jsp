<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="id">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Anggota - Kas Kegiatan</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" />
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  <style>
    body { background-color: #f8f9fa; }
    .navbar-brand { color: white !important; font-weight: 600; }
    .card { border: none; border-radius: 10px; box-shadow: 0 2px 6px rgba(0,0,0,0.1); }
    footer { text-align: center; color: #777; padding: 15px; margin-top: 40px; }
  </style>
</head>
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