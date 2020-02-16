package ysl.admin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ysl.common.controller.AbstractController;

public class AdminProdUploadYSL extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.setViewPage("/WEB-INF/main/adminProdUploadYSL.jsp");

	}

}
