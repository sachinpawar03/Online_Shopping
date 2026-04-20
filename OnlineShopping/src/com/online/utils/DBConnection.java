package com.online.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnection {

	public static void main(String[] args) {
		try {
			// 1) Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 2) Establish Connection (UPDATED - Railway DB)
			Connection con = DriverManager.getConnection(
					"jdbc:mysql://gondola.proxy.rlwy.net:20821/railway?useSSL=true&requireSSL=true&verifyServerCertificate=false",
					"root", "cRYKSiHAnswADANuOrTjjcYmiraWnvHd");

			// 3) Create Statement
			Statement stmt = con.createStatement();

			// 4) Test Query
			String query = "SELECT * FROM users";
			ResultSet rs = stmt.executeQuery(query);

			System.out.println("\nUsers Table Data:");
			while (rs.next()) {
				System.out.println(rs.getInt("user_id") + " | " + rs.getString("name") + " | " + rs.getString("email")
						+ " | " + rs.getString("role"));
			}

			// 5) Close Connection
			con.close();
			System.out.println("\nConnection Successful!");

		} catch (ClassNotFoundException e) {
			System.out.println("Driver Loading Failed!");
			e.printStackTrace();
		} catch (SQLException e) {
			System.out.println("Database Connection Failed!");
			e.printStackTrace();
		}
	}

	// ⭐ Used by your DAO classes (IMPORTANT)
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");

			String url = System.getenv("DB_URL");
			String user = System.getenv("DB_USER");
			String pass = System.getenv("DB_PASS");

			// ✅ Fallback if env not set (IMPORTANT FIX)
			if (url == null || user == null || pass == null) {
				System.out.println("⚠️ Using fallback Railway DB config");

				url = "jdbc:mysql://gondola.proxy.rlwy.net:20821/railway?useSSL=true&requireSSL=true&verifyServerCertificate=false";
				user = "root";
				pass = "cRYKSiHAnswADANuOrTjjcYmiraWnvHd";
			}

			System.out.println("URL: " + url);
			System.out.println("USER: " + user);

			Connection con = DriverManager.getConnection(url, user, pass);

			System.out.println("✅ Connected to Railway DB");
			return con;

		} catch (Exception e) {
			System.out.println("❌ DB Connection Failed");
			e.printStackTrace();
			return null;
		}
	}
}