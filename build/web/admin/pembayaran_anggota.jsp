<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="../fungsi/koneksi.jsp" %>
<%@ include file="../partisi/head.jsp" %>
  <!-- Navbar -->
<%@ include file="partisi/navbar.jsp" %>

 <%
     String id = request.getParameter("id");
     PreparedStatement stmt = null;
    ResultSet rs = null;    
    String sql = "SELECT * FROM kegiatan WHERE id=?";
    stmt = conn.prepareStatement(sql);
    stmt.setString(1, id);
    rs = stmt.executeQuery();
    rs.next();
    %>
    <h5 class="fw-bold mb-3 text-center" style="margin-top: 5rem">Pembayaran Anggota || <%= rs.getNString("nama_kegiatan") %></h5>
<div class="card p-4 mb-4 shadow-sm" >

    <table class="table table-bordered table-hover">
        <thead class="table-light">
            <tr>
                <th>No</th>
                <th>Nama</th>
                <th>Sudah Bayar</th>
                <th>Target</th>
                <th>Kurang</th>
                <th>Status</th>
            </tr>
        </thead>
        <tbody>
            <%
                int no = 1;

                PreparedStatement stra = conn.prepareStatement(
                    "SELECT u.username, " +
                    "COALESCE(SUM(p.jumlah_bayar), 0) AS sudah_bayar, " +
                    "k.target_kas AS target_kas, " +
                    "(k.target_kas - COALESCE(SUM(p.jumlah_bayar), 0)) AS kurang " +
                    "FROM users u " +
                    "LEFT JOIN pembayaran p ON u.nim = p.nim AND p.id_kegiatan = ? AND p.status = 'diterima' " +
                    "LEFT JOIN kegiatan k ON k.id = ? " +
                    "WHERE u.role = 'user'"+
                    "GROUP BY u.nim"
                );

                stra.setString(1, id);
                stra.setString(2, id);

                ResultSet rsra = stra.executeQuery();

                while (rsra.next()) {
                    int sudahBayar = rsra.getInt("sudah_bayar");
                    int target_kas = rsra.getInt("target_kas");
                    int kurang = rsra.getInt("kurang");

                    String status = (kurang <= 0) ? "Lunas" : "Belum Lunas";
                    String badgeClass = (kurang <= 0) ? "bg-success" : "bg-warning text-dark";
            %>
            <tr>
                <td><%= no++ %></td>
                <td><%= rsra.getString("username") %></td>
                <td>Rp <%= String.format("%,d", sudahBayar).replace(",", ".") %></td>
                <td>Rp <%= String.format("%,d", target_kas).replace(",", ".") %></td>
                <td>Rp <%= String.format("%,d", kurang).replace(",", ".") %></td>
                <td>
                    <span class="badge <%= badgeClass %> px-3 py-2">
                        <%= status %>
                    </span>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</div>
            <a href="detail_kegiatan.jsp?id=<%= id %>" 
   class="btn btn-primary position-fixed bottom-0 start-0 m-4 shadow-lg d-inline-flex justify-content-center align-items-center">
    <i class="bi bi-arrow-left"></i> <span class="material-symbols-outlined">arrow_back</span>
</a>