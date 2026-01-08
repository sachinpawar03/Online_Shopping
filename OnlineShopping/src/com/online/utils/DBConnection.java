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

			// 2) Establish Connection (your DB details)
			Connection con = DriverManager.getConnection(
				    "jdbc:mysql://localhost:3306/shopping_db?useSSL=false&allowPublicKeyRetrieval=true",
				    "root", "Sachin@123"
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

	// ⭐ THIS is the method your project (UserDAO) actually uses
	public static Connection getConnection() {
		Connection con = null;

		try {
			// 1) Load Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// 2) Establish Connection
			con = DriverManager.getConnection(
				    "jdbc:mysql://localhost:3306/shopping_db?useSSL=false&allowPublicKeyRetrieval=true",
				    "root", "Sachin@123"
				);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return con; // ⭐ Now it returns a REAL connection, not null!
	}
}
