package com.online.controller;

import com.online.dao.ProductDAO;
import com.online.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/updateProduct")
@MultipartConfig
public class UpdateProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String category = req.getParameter("category");
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Part imagePart = req.getPart("image");
        String newImage = imagePart.getSubmittedFileName();

        ProductDAO dao = new ProductDAO();
        Product existing = dao.getById(id);

        String finalImage = existing.getImage();

        if (newImage != null && !newImage.isEmpty()) {

            String uploadPath = req.getServletContext().getRealPath("") + "images";
            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdir();

            imagePart.write(uploadPath + File.separator + newImage);
            finalImage = newImage;
        }

        Product updated = new Product();
        updated.setProductId(id);
        updated.setName(name);
        updated.setDescription(description);
        updated.setPrice(price);
        updated.setCategory(category);
        updated.setQuantity(quantity);
        updated.setImage(finalImage);

        dao.updateProduct(updated);

        resp.sendRedirect("admin/manageProducts.jsp");
    }
}
