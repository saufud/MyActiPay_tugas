<nav class="navbar navbar-expand-lg bg-primary fixed-top navbar-dark">
  <div class="container">

    <a class="navbar-brand d-flex align-items-center gap-2" href="#">
      <img src="img/logo-nav.png" class="rounded" style="width: 2rem; height: 2rem;">
      MyActiPay
    </a>

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNavbar">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="mainNavbar">
      <ul class="navbar-nav ms-auto align-items-lg-center gap-lg-3">

        <li class="nav-item">
          <a class="nav-link text-light" href="index.jsp">Home</a>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle text-light" href="#" id="keuanganDropdown" role="button" data-bs-toggle="dropdown">
            pembayaran
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="riwayat_pembayaran.jsp">Riwayat pembayaran</a></li>
            <li><a class="dropdown-item" href="rekap_pembayaran.jsp">Rekap Pembayaran</a></li>
          </ul>
        </li>

        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle text-light" href="#" id="kegiatanDropdown" role="button" data-bs-toggle="dropdown">
            Kegiatan
          </a>
          <ul class="dropdown-menu">
            <li><a class="dropdown-item" href="#">Request</a></li>
            <li><a class="dropdown-item" href="#">Kritik & Saran</a></li>
          </ul>
        </li>

        <li class="nav-item">
          <a class="nav-link text-light" href="#">Kontak Admin</a>
        </li>

        <li class="nav-item">
          <a class="nav-link text-light" onclick="return confirmLogout(event)" href="fungsi/pLogout.jsp">
            Logout
          </a>
        </li>

      </ul>
    </div>

  </div>
</nav>
