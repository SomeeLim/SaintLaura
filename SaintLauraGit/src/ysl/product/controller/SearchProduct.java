package ysl.product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ysl.common.controller.AbstractController;
import ysl.product.model.InterProductDAO;
import ysl.product.model.ProductDAO;

public class SearchProduct extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String searchProduct = request.getParameter("searchProduct");
		String searhProdCat = request.getParameter("searhProdCat");
		String searchProdCatDetail = request.getParameter("searchProdCatDetail");
		String searhProdColor = request.getParameter("searhProdColor");		
		
		request.setAttribute("searchProduct", searchProduct);	
		request.setAttribute("searhProdCat", searhProdCat);	
		request.setAttribute("searchProdCatDetail", searchProdCatDetail);	
		request.setAttribute("searhProdColor", searhProdColor);	
		super.setViewPage("/WEB-INF/product/searchProduct.jsp");

	}

}
