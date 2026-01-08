package com.online.dao;

import com.online.model.User;
import com.online.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    // ============================
    // REGISTER USER
    // ============================
    public boolean register(User u) {
        String sql = "INSERT INTO users(name,email,password,role,status) VALUES(?,?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());

            // Default role = "user"
            String role = (u.getRole() == null || u.getRole().isEmpty()) ? "user" : u.getRole();
            ps.setString(4, role);

            // Default status = active
            ps.setString(5, "active");

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ============================
    // LOGIN
    // ============================
    public User login(String email, String password) {
        String sql = "SELECT * FROM users WHERE email=? AND password=?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();

                // Handle both `id` and `userId` column names safely
                if (columnExists(rs, "userId")) {
                    u.setUserId(rs.getInt("userId"));
                } else {
                    u.setUserId(rs.getInt("id"));
                }

                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));

                // LOAD STATUS
                if (columnExists(rs, "status")) {
                    u.setStatus(rs.getString("status"));
                }

                return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // ============================
    // GET ALL USERS (For Admin)
    // ============================
    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();

        String sql = "SELECT * FROM users";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                User u = new User();

                // Handle id column safely
                if (columnExists(rs, "userId")) {
                    u.setUserId(rs.getInt("userId"));
                } else {
                    u.setUserId(rs.getInt("id"));
                }

                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setStatus(rs.getString("status"));


                // LOAD STATUS
                if (columnExists(rs, "status")) {
                    u.setStatus(rs.getString("status"));
                }

                list.add(u);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }


    // ============================
    // UTILITY: Check if column exists
    // ============================
    private boolean columnExists(ResultSet rs, String columnName) {
        try {
            rs.findColumn(columnName);
            return true;
        } catch (SQLException e) {
            return false;
        }
    }


    // ==============================
    // UPDATE USER STATUS (BLOCK / UNBLOCK)
    // ==============================
    public void updateStatus(int id, String status) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                     "UPDATE users SET status=? WHERE id=?")) {

            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
