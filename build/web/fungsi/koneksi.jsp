<%@ page import="java.sql.*" %>

<%
    String host = "jdbc:mysql://localhost:3307/kas_kelas";
String user = "root";
String pass = "";


    Connection conn = null;
    

    try {
        // Load driver MySQL
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Koneksi
        conn = DriverManager.getConnection(host, user, pass);


    } catch (Exception e) {
        out.println("koneksi gagal : " + e.getMessage());
    }
   
%>
