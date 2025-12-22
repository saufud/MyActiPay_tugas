<%@ page import="java.sql.*, java.io.*, org.mindrot.jbcrypt.BCrypt" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ include file="koneksi.jsp" %>

<%
    // session
    HttpSession sess = request.getSession();

    // konfigurasi upload
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    String nim = "";
    String username = "";
    String password = "";
    String no_telp = "";
    String jenis_kelamin = "";
    String profile = "";

    try {
        // Parse semua input form
        java.util.List<FileItem> formItems = upload.parseRequest(request);

        for (FileItem item : formItems) {

            if (item.isFormField()) {
                switch (item.getFieldName()) {
                    case "nim": nim = item.getString(); break;
                    case "username": username = item.getString(); break;
                    case "password": password = item.getString(); break;
                    case "no_telp": no_telp = item.getString(); break;
                    case "jenis_kelamin": jenis_kelamin = item.getString(); break;
                }

            } else {
                // FILE UPLOAD
                if (item.getSize() == 0) {
                    sess.setAttribute("alert", "register_failed");
                    out.println("Profile belum diupload");
                    return;
                }

                String fileName = item.getName();
                String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

                if (!ext.equals("jpg") && !ext.equals("jpeg") && !ext.equals("png")) {
                    sess.setAttribute("alert", "register_failed");
                    out.println("Harus upload gambar JPG/PNG");
                    return;
                }

                if (item.getSize() > 1_000_000) {
                    sess.setAttribute("alert", "register_failed");
                    out.println("Ukuran file terlalu besar");
                    return;
                }

                String randomName = username + "_" + System.currentTimeMillis();
                String uploadPath = application.getRealPath("/") + "img/profile/" + randomName;

                File uploadedFile = new File(uploadPath);
                item.write(uploadedFile);

                profile = randomName;
            }
        }


        String cekSql = "SELECT nim FROM users WHERE nim = ?";
        PreparedStatement cekStmt = conn.prepareStatement(cekSql);
        cekStmt.setString(1, nim);
        ResultSet rs = cekStmt.executeQuery();

        if (rs.next()) {
            sess.setAttribute("alert", "register_failed");
            response.sendRedirect("../daftar.jsp");
            return;
        }


        String hashed = BCrypt.hashpw(password, BCrypt.gensalt());

        String sql = "INSERT INTO users(nim, username, password, profil, no_telpon, role, jenis_kelamin) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, nim);
        stmt.setString(2, username);
        stmt.setString(3, hashed);
        stmt.setString(4, profile);
        stmt.setString(5, no_telp);
        stmt.setString(6, "USER");
        stmt.setString(7, jenis_kelamin);

        if (stmt.executeUpdate() > 0) {
            sess.setAttribute("alert", "register_success");
            response.sendRedirect("../login.jsp?success=akun berhasil terdaftar");
            return;
        } else {
            sess.setAttribute("alert", "register_failed");
            out.println("Gagal membuat akun");
        }

    } catch (Exception e) {
        e.printStackTrace();
        sess.setAttribute("alert", "register_failed");
        out.println("Error: " + e.getMessage());
    }
%>

