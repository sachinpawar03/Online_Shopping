package com.online.controller;

import com.online.dao.ProductDAO;
import com.online.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;

@WebServlet("/addProduct")
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // KEEP SESSION ACTIVE
        HttpSession session = req.getSession();
        session.setMaxInactiveInterval(1800); // 30 mins

        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String category = req.getParameter("category");
        int quantity = Integer.parseInt(req.getParameter("quantity"));

        Part imagePart = req.getPart("image");
        String imageName = imagePart.getSubmittedFileName();

        // Save image
        String uploadPath = req.getServletContext().getRealPath("") + "images";
        File folder = new File(uploadPath);
        if (!folder.exists()) folder.mkdir();

        imagePart.write(uploadPath + File.separator + imageName);

        // Save DB
        Product p = new Product();
        p.setName(name);
        p.setDescription(description);
        p.setPrice(price);
        p.setCategory(category);
        p.setQuantity(quantity);
        p.setImage(imageName);

        ProductDAO dao = new ProductDAO();
        dao.addProduct(p);

        // CORRECT redirect (preserves session)
        resp.sendRedirect(req.getContextPath() + "/admin/manageProducts.jsp");
    }
}
