<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ include file="fungsi/koneksi.jsp" %>

<%
    // Ambil id user dari session
    Integer idUser = (Integer) session.getAttribute("id_user");
    if (idUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    ResultSet rs = null;
    try {
        PreparedStatement stmt = null;
        String sql = "SELECT * FROM users WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setInt(1, idUser);
        rs = stmt.executeQuery();
        rs.next();
        

    } catch (Exception e) {
        out.print(e.getMessage());
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <title>Detail Akun</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>

<body class="bg-light">

<%
    String alert = (String) session.getAttribute("alert");

    if (alert != null) {

        if (alert.equals("update_success")) {
%>
            <script>Swal.fire('Berhasil!', 'Perubahan telah disimpan', 'success');</script>
<%
        } else if (alert.equals("update_failed")) {
%>
            <script>Swal.fire('Gagal!', 'Perubahan gagal disimpan', 'error');</script>
<%
        }

        session.removeAttribute("alert");
    }
%>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4 class="m-0">Detail Akun</h4>
        </div>

        <div class="card-body">

            <div class="row">
                <div class="col-md-4 text-center">

                    <img src="img/profile/<%= rs.getString("profil") %>"
                         class="rounded-circle border shadow"
                         style="width:180px; height:180px; object-fit:cover;">
                </div>

                <div class="col-md-8">
                    <table class="table table-bordered">
                        <tr>
                            <th>Nama</th>
                            <td><%= rs.getString("username") %>
</td>
                        </tr>

                        <tr>
                            <th>NIM</th>
                            <td><%= rs.getString("nim") %></td>
                        </tr>

                        <tr>
                            <th>No Telepon</th>
                            <td><%= rs.getString("no_telpon") %></td>
                        </tr>

                        <tr>
                            <th>Jenis Kelamin</th>
                            <td><%= rs.getString("jenis_kelamin") %></td>
                        </tr>
                    </table>
                </div>
            </div>

            <a href="index.jsp" class="btn btn-secondary mt-3">Kembali</a>
            <a href="edit_akun.jsp" class="btn btn-primary float-end mt-3">Edit Akun</a>

        </div>
    </div>
</div>

</body>
</html>
