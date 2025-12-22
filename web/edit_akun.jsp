<%@ page import="java.sql.*" %>
<%@ include file="fungsi/koneksi.jsp" %>


<%
    // Ambil ID user dari session
    Integer idUser = (Integer) session.getAttribute("id_user");
    if (idUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Ambil data user dari database
    ResultSet rs = null;
    try {
        String sql = "SELECT * FROM users WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
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
    <title>Edit Akun</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

    <div class="container mt-5">
        <div class="card shadow">
            <div class="card-header bg-warning text-dark">
                <h4 class="m-0">Edit Akun</h4>
            </div>

            <form action="fungsi/pUpdate.jsp" method="POST" class="p-3" enctype="multipart/form-data">
<div class="row">

    <!-- FOTO PROFILE -->
    <div class="col-md-4 text-center">

        <img src="img/profile/<%= rs.getString("profil") %>"
             class="rounded-circle border shadow"
             style="width:180px; height:180px; object-fit:cover;">

        <div class="mt-3">
            <label class="form-label">Ganti Foto Baru:</label>
            <input type="file" class="form-control" name="profile">
        </div>

    </div>

    <!-- FORM INPUT -->
    <div class="col-md-8">

        <div class="mb-3">
            <label class="form-label">NIM</label>
            <input name="nim" type="text" class="form-control"
                   value="<%= rs.getString("nim") %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Nama Lengkap</label>
            <input name="username" type="text" class="form-control"
                   value="<%= rs.getString("username") %>">
        </div>

        <div class="mb-3">
            <label class="form-label">No. Telp</label>
            <input name="no_telp" type="text" class="form-control"
                   value="<%= rs.getString("no_telpon") %>">
        </div>

        <div class="mb-3">
            <label class="form-label">Jenis Kelamin</label>
            <select name="jenis_kelamin" class="form-select">
                <option value="Laki-laki"
                    <%= rs.getString("jenis_kelamin").equals("Laki-laki") ? "selected" : "" %>>
                    Laki-laki
                </option>

                <option value="Perempuan"
                    <%= rs.getString("jenis_kelamin").equals("Perempuan") ? "selected" : "" %>>
                    Perempuan
                </option>
            </select>
        </div>

        <div class="d-flex">
            <a href="detail_akun.jsp" class="btn btn-secondary">Batal</a>
            <button name="simpan" type="submit" class="btn btn-primary ms-auto">Simpan Perubahan</button>
        </div>

    </div>
</div>
</form>


        </div>
    </div>

</body>

</html>
