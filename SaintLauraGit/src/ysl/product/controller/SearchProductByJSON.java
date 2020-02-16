package ysl.product.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import ysl.common.controller.AbstractController;
import ysl.product.model.InterProductDAO;
import ysl.product.model.ProductDAO;

public class SearchProductByJSON extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String searchProduct = request.getParameter("searchProduct");
		String searhProdCat = request.getParameter("searhProdCat");
		String searchProdCatDetail = request.getParameter("searchProdCatDetail");
		String searhProdColor = request.getParameter("searhProdColor");		
		String searhStartNo = request.getParameter("searhStartNo");
		String searhEndNo = String.valueOf(Integer.parseInt(searhStartNo)+11);
		
	//	System.out.println("searhProdCat : " +searhProdCat);
	//	System.out.println("searchProdCatDetail : " +searchProdCatDetail);
	//	System.out.println("searhProdColor : " +searhProdColor);
		
		HashMap<String, String> searchMap = new HashMap<String, String>();
		
		searchMap.put("searchProduct", searchProduct);
		searchMap.put("searhProdCat", searhProdCat);
		searchMap.put("searchProdCatDetail", searchProdCatDetail);
		searchMap.put("searhProdColor", searhProdColor);
		searchMap.put("searhStartNo", searhStartNo);
		searchMap.put("searhEndNo", searhEndNo);
		
		InterProductDAO pdao = new ProductDAO();
		
		List<HashMap<String, String>> searchProdList = pdao.getSearchList(searchMap);
		
		JSONArray jsonArr = new JSONArray();
		
		if(searchProdList!=null) {
			for(HashMap<String, String> prodMap : searchProdList) {
				JSONObject jsobj = new JSONObject();
				// JSONObject는 JSON형태{키:값}의 데이터로 만들어주는 것이다.
				jsobj.put("pnum", prodMap.get("pnum"));
				jsobj.put("pname", prodMap.get("pname"));
				jsobj.put("price", prodMap.get("price"));
				jsobj.put("pcategory_fk", prodMap.get("pcategory_fk"));
				jsobj.put("pimage1", prodMap.get("pimage1"));
				jsobj.put("searhStartNo", prodMap.get("searhStartNo"));
				jsobj.put("pimage2", prodMap.get("pnum"));
				jsobj.put("pcolor", prodMap.get("pcolor"));

				jsonArr.put(jsobj);
			}
		}
			 				
		String result = jsonArr.toString();

		request.setAttribute("result", result);
		
		super.setViewPage("/WEB-INF/jsonResult.jsp");

	}

}
