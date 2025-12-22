<%@ include file="../fungsi/koneksi.jsp" %>
<%@ include file="../partisi/head.jsp" %>
<%@ include file="partisi/navbar.jsp" %>

<%
    String id = request.getParameter("id");
    String sql = "SELECT * FROM kegiatan WHERE id=?";
    PreparedStatement stmt = conn.prepareStatement(sql);
    stmt.setString(1, id);
    ResultSet rs = stmt.executeQuery();
    rs.next();
%>

<div class="container  " style="margin-top: 6rem;">

    <div class="card shadow p-4 w-75 mx-auto" >
        <h4 class="fw-semibold mb-3 text-center">Update Kegiatan Kas</h4>

        <form action="fungsi/pUpdate_kegiatan.jsp?id=<%= id %>" method="POST">

            <div class="mb-3">
                <label class="form-label">Nama Kegiatan</label>
                <input type="text" class="form-control" name="nama_kegiatan"
                       value="<%= rs.getString("nama_kegiatan") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Target per Anggota (Rp)</label>
                <input type="number" class="form-control" name="target_kas"
                       value="<%= rs.getString("target_kas") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Tanggal Akhir</label>
                <input type="date" class="form-control" name="tanggal_akhir"
                       value="<%= rs.getString("tanggal_akhir") %>" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Status</label>
                <select class="form-select" name="status">
                    <option value="aktif"   <%= rs.getString("status").equals("aktif") ? "selected":"" %>>Aktif</option>
                    <option value="selesai" <%= rs.getString("status").equals("selesai") ? "selected":"" %>>Selesai</option>
                </select>
            </div>

            <button type="submit" class="btn btn-primary w-100">Update Data</button>
        </form>
    </div>
                <a href="detail_kegiatan.jsp?id=<%= rs.getString("id") %>" 
   class="btn btn-primary position-fixed bottom-0 start-0 m-4 shadow-lg d-inline-flex justify-content-center align-items-center">
    <i class="bi bi-arrow-left"></i> <span class="material-symbols-outlined">arrow_back</span>
</a>
</div>
<%@ include file="../partisi/fother.jsp" %>
