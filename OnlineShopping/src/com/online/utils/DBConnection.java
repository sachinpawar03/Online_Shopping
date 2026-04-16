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
				    "jdbc:mysql://gondola.proxy.rlwy.net:20821/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
				    "root", "cRYKSiHAnswADANuOrTjjcYmiraWnvHd"
				);

			// 3) Create Statement
			Statement stmt = con.createStatement();

			// 4) Test Query
			String query = "SELECT * FROM users"; 
			ResultSet rs = stmt.executeQuery(query);

			System.out.println("\nUsers Table Data:");
			while (rs.next()) {
				System.out.println(rs.getInt("user_id") + " | " + rs.getString("name") + 
						" | " + rs.getString("email") + " | " + rs.getString("role"));
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
		Connection con = null;

		try {
			// 1) Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 2) Establish Connection (UPDATED)
			con = DriverManager.getConnection(
				    "jdbc:mysql://gondola.proxy.rlwy.net:20821/railway?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
				    "root", "cRYKSiHAnswADANuOrTjjcYmiraWnvHd"
				);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return con; // ✅ now works in Render
	}
}