package com.online.dao;

import com.online.model.Order;
import com.online.model.OrderItem;
import com.online.utils.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

	// ==============================
	// CREATE ORDER
	// ==============================
	public int createOrder(int userId, double total, List<OrderItem> items) {

		String insertOrder = "INSERT INTO orders(user_id, total) VALUES(?, ?)";
		String insertItem = "INSERT INTO order_items(order_id, product_id, qty, price) VALUES(?,?,?,?)";

		try (Connection conn = DBConnection.getConnection()) {

			conn.setAutoCommit(false);

			try (PreparedStatement ps = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {

				ps.setInt(1, userId);
				ps.setDouble(2, total);
				ps.executeUpdate();

				ResultSet keys = ps.getGeneratedKeys();

				if (keys.next()) {

					int orderId = keys.getInt(1);

					try (PreparedStatement pis = conn.prepareStatement(insertItem)) {

						for (OrderItem it : items) {

							pis.setInt(1, orderId);
							pis.setInt(2, it.getProductId());
							pis.setInt(3, it.getQuantity());
							pis.setDouble(4, it.getPrice());
							pis.addBatch();
						}

						pis.executeBatch();
					}

					conn.commit();
					return orderId;
				} else {
					conn.rollback();
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return -1;
	}

	// ==============================
	// GET ORDERS FOR USER ✔ THIS IS WHAT YOU MISSED
	// ==============================
	public List<Order> getOrdersByUserId(int userId) {

		List<Order> list = new ArrayList<>();
		String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Order o = new Order();

				o.setId(rs.getInt("id"));
				o.setUserId(rs.getInt("user_id"));
				o.setTotal(rs.getDouble("total"));
				o.setStatus(rs.getString("status"));
				o.setCreatedAt(rs.getTimestamp("created_at"));

				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// ==============================
	// GET ITEMS OF AN ORDER (WITH IMAGE)
	// ==============================
	public List<OrderItem> getOrderItems(int orderId) {

		List<OrderItem> list = new ArrayList<>();

		String sql = "SELECT oi.qty, oi.price, p.name AS product_name, p.image AS product_image "
				+ "FROM order_items oi " + "JOIN products p ON oi.product_id = p.id " + "WHERE oi.order_id = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ps.setInt(1, orderId);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				OrderItem item = new OrderItem();
				item.setProductName(rs.getString("product_name"));
				item.setProductImage(rs.getString("product_image"));
				item.setQuantity(rs.getInt("qty"));
				item.setPrice(rs.getDouble("price"));

				list.add(item);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	// ==============================
	// GET ALL ORDERS FOR ADMIN
	// ==============================
	public List<Order> getAllOrders() {

		List<Order> list = new ArrayList<>();

		String sql = "SELECT * FROM orders ORDER BY id DESC";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {

				Order o = new Order();
				o.setId(rs.getInt("id"));
				o.setUserId(rs.getInt("user_id"));
				o.setTotal(rs.getDouble("total"));
				o.setStatus(rs.getString("status"));
				o.setCreatedAt(rs.getTimestamp("created_at"));

				list.add(o);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

//==============================
//UPDATE ORDER STATUS
//==============================
	public void updateOrderStatus(int orderId, String status) {
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status=? WHERE id=?")) {

			ps.setString(1, status);
			ps.setInt(2, orderId);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public void updateStatus(int orderId, String status) {
		try (Connection conn = DBConnection.getConnection();
				PreparedStatement ps = conn.prepareStatement("UPDATE orders SET status=? WHERE id=?")) {

			ps.setString(1, status);
			ps.setInt(2, orderId);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
