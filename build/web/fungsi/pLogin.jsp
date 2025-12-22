<%@ page import="java.sql.*, org.mindrot.jbcrypt.BCrypt" %>
<%@ include file="koneksi.jsp" %>
<%
    request.setCharacterEncoding("UTF-8");

    HttpSession sess = request.getSession();

    String nim = request.getParameter("nim");
    String password = request.getParameter("password");

    PreparedStatement stmt = null;
    ResultSet rs = null;
    try {
        
       String sql = "SELECT * FROM users WHERE nim = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nim);
        rs = stmt.executeQuery();


        if (rs.next()) {

            String hashedPassword = rs.getString("password");

            // cek hash pw
            if (BCrypt.checkpw(password, hashedPassword)) {

                sess.setAttribute("id_user", rs.getInt("id"));
                sess.setAttribute("username", rs.getString("username"));
                sess.setAttribute("nim", rs.getString("nim"));
                sess.setAttribute("profil", rs.getString("profil"));
                sess.setAttribute("role", rs.getString("role"));
                

                if (rs.getString("role").equals("ADMIN")) {
                    response.sendRedirect("../admin/index.jsp");
                    sess.setAttribute("alert", "login_success");
                    return;
                } else {
                    response.sendRedirect("../index.jsp");
                    sess.setAttribute("alert", "login_success");
                    return;
                }

            } else {
                
                response.sendRedirect("../login.jsp?gagal=password salah");
                sess.setAttribute("alert", "login_failed");
                return;
            }

        } else {
            sess.setAttribute("alert", "login_failed");
            response.sendRedirect("../login.jsp?gagal=user tidak ditemukan");
            return;
        }

    } catch (Exception e) {
        e.printStackTrace();
        sess.setAttribute("alert", "login_failed");
        response.sendRedirect("../login.jsp?gagal=error");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (stmt != null) stmt.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>
