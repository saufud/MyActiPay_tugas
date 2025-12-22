<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ include file="koneksi.jsp" %>

<%
    request.setCharacterEncoding("UTF-8");

    Integer idUser = (Integer) session.getAttribute("id_user");
    if (idUser == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    // Variabel untuk data update
    String nim = "";
    String username = "";
    String no_telp = "";
    String jenis_kelamin = "";
    String newProfileFile = null;

    boolean isMultipart = ServletFileUpload.isMultipartContent(request);

    try {
        if (isMultipart) {

            DiskFileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);

            java.util.List<FileItem> items = upload.parseRequest(request);

            for (FileItem item : items) {

                if (item.isFormField()) {
                    // Input text biasa
                    switch (item.getFieldName()) {
                        case "nim":
                            nim = item.getString("UTF-8");
                            break;
                        case "username":
                            username = item.getString("UTF-8");
                            break;
                        case "no_telp":
                            no_telp = item.getString("UTF-8");
                            break;
                        case "jenis_kelamin":
                            jenis_kelamin = item.getString("UTF-8");
                            break;
                    }

                } else {
                    // File upload
                    if (!item.getName().isEmpty()) {
                        String fileName = System.currentTimeMillis() + "_" + item.getName();
                        String uploadPath = application.getRealPath("/") + "img/profile/" + fileName;

                        File fileSave = new File(uploadPath);
                        item.write(fileSave);

                        newProfileFile = fileName;
                    }
                }
            }
        }

        // Ambil profil lama jika tidak upload foto baru
        if (newProfileFile == null) {

            String sql = "SELECT profil FROM users WHERE id=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, idUser);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                newProfileFile = rs.getString("profil");
            }
        }

        // UPDATE DATA
        String sql = "UPDATE users SET username=?, nim=?, no_telpon=?, jenis_kelamin=?, profil=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);

        stmt.setString(1, username);
        stmt.setString(2, nim);
        stmt.setString(3, no_telp);
        stmt.setString(4, jenis_kelamin);
        stmt.setString(5, newProfileFile);
        stmt.setInt(6, idUser);

        int hasil = stmt.executeUpdate();

        if (hasil > 0) {
            session.setAttribute("alert", "update_success");
            response.sendRedirect("../detail_akun.jsp");
            return;
        } else {
            session.setAttribute("alert", "update_failed");
            response.sendRedirect("../detail_akun.jsp");
            return;
        }

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    }
%>
