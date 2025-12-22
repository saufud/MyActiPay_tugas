<%@ page import="java.sql.*, java.io.*" %>
<%@ page import="org.apache.commons.fileupload.*, org.apache.commons.fileupload.disk.*, org.apache.commons.fileupload.servlet.*" %>
<%@ include file="../../fungsi/koneksi.jsp" %>

<%
    HttpSession sess = request.getSession();

    // Konfigurasi upload file
    DiskFileItemFactory factory = new DiskFileItemFactory();
    ServletFileUpload upload = new ServletFileUpload(factory);

    String nama_kegiatan = "";
    int target_kas = 0;
    String tgl_akhir = "";
    String gambar = "";

    try {
        // Ambil semua field form
        java.util.List<FileItem> formItems = upload.parseRequest(request);

        for (FileItem item : formItems) {

            if (item.isFormField()) {

                switch (item.getFieldName()) {

                    case "nama_kegiatan":
                        nama_kegiatan = item.getString("UTF-8");
                        break;

                    case "target_kas":
                        try {
                            target_kas = Integer.parseInt(item.getString());
                        } catch (Exception e) {
                            target_kas = 0;
                        }
                        break;

                    case "tgl_akhir":
                        tgl_akhir = item.getString();
                        break;
                }

            } else {
                // FILE UPLOAD (gambar)
                if (item.getSize() > 0) {

                    String fileName = item.getName();
                    String ext = fileName.substring(fileName.lastIndexOf(".") + 1).toLowerCase();

                    // Validasi tipe file
                    if (!ext.equals("jpg") && !ext.equals("jpeg") && !ext.equals("png")) {
                       sess.setAttribute("alert", "gambar_field_format");
                       response.sendRedirect("../add_kegiatan.jsp");
                        return;
                    }

                    // Validasi ukuran
                    if (item.getSize() > 1_000_000) {
                        sess.setAttribute("alert", "gambar_field_sz");
                        response.sendRedirect("../add_kegiatan.jsp");
                        return;
                    }

                    // Nama baru untuk file
                    String newName = "keg_" + java.util.UUID.randomUUID().toString() + "." + ext;

                    // Lokasi simpan
                    String uploadPath = application.getRealPath("/") + "img/gambar_kegiatan/" + newName;
                    File uploadedFile = new File(uploadPath);

                    // Simpan file
                    item.write(uploadedFile);

                    gambar = newName;
                }
            }
        }
        String id = "KEG" + System.currentTimeMillis();
        String sql = "INSERT INTO kegiatan (id,nama_kegiatan, target_kas, tanggal_mulai, tanggal_akhir, status, total_kas, gambar) "
                   + "VALUES (?,?, ?, NOW(), ?, 'aktif', 0, ?)";

        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, id);
        stmt.setString(2, nama_kegiatan);
        stmt.setInt(3, target_kas);
        stmt.setString(4, tgl_akhir);
        stmt.setString(5, gambar);

        if (stmt.executeUpdate() > 0) {
             response.sendRedirect("../index.jsp");
            sess.setAttribute("alert", "add_kegiatan_success");
            
            return;
        } else {
            sess.setAttribute("alert", "add_kegiatan_failed");
            response.sendRedirect("../add_kegiatan.jsp");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    }
%>
