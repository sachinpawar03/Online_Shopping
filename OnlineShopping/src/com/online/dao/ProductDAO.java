package com.online.dao;

import com.online.model.Product;
import com.online.utils.DBConnection;
import java.sql.*;
import java.util.*;

public class ProductDAO {

	// =======================
	// GET ALL PRODUCTS
	// =======================
	public List<Product> getAll() {
		List<Product> list = new ArrayList<>();
		String sql = "SELECT * FROM products";

		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {
				Product p = new Product();
				p.setProductId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setPrice(rs.getDouble("price"));
				p.setCategory(rs.getString("category"));
				p.setQuantity(rs.getInt("quantity"));
				p.setImage(rs.getString("image"));

				list.add(p);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}

	// =======================
	// GET PRODUCT BY ID
	// =======================
	public Product getById(int id) {
		String sql = "SELECT * FROM products WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				Product p = new Product();
				p.setProductId(rs.getInt("id"));
				p.setName(rs.getString("name"));
				p.setDescription(rs.getString("description"));
				p.setPrice(rs.getDouble("price"));
				p.setCategory(rs.getString("category"));
				p.setQuantity(rs.getInt("quantity"));
				p.setImage(rs.getString("image"));
				return p;
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return null;
	}

	// =======================
	// ADD PRODUCT
	// =======================
	public boolean addProduct(Product p) {
		String sql = "INSERT INTO products(name,description,price,category,quantity,image) VALUES(?,?,?,?,?,?)";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setString(4, p.getCategory());
			ps.setInt(5, p.getQuantity());
			ps.setString(6, p.getImage());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	// =======================
	// UPDATE PRODUCT
	// =======================
	public boolean updateProduct(Product p) {
		String sql = "UPDATE products SET name=?, description=?, price=?, category=?, quantity=?, image=? WHERE id=?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setString(4, p.getCategory());
			ps.setInt(5, p.getQuantity());
			ps.setString(6, p.getImage());
			ps.setInt(7, p.getProductId());

			return ps.executeUpdate() > 0;

		} catch (SQLException e) {
			e.printStackTrace();
		}

		return false;
	}

	// =======================
	// DELETE PRODUCT
	// =======================
	public boolean deleteProduct(int id) {
		String sql = "DELETE FROM products WHERE id=?";
		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, id);
			return ps.executeUpdate() > 0;

		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
}