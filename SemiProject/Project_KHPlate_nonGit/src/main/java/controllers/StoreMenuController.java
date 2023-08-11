package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import commons.SecurityUtils;
import dao.StoreMenuDAO;
import dto.StoreMenuDTO;

@WebServlet("*.storeMenu")
public class StoreMenuController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf8");
		String cmd = request.getRequestURI();
		
		try {
			if(cmd.equals("/delete.storeMenu")) {
				int menuID = Integer.parseInt(request.getParameter("menuID"));
				int storeID = Integer.parseInt(request.getParameter("storeID"));
				
				int result = StoreMenuDAO.getInstance().deleteByID(menuID);
				
				response.sendRedirect("/view.store?storeID="+storeID);
			}else if(cmd.equals("/modify.storeMenu")) {
				int storeID = Integer.parseInt(request.getParameter("storeID"));
				int menuLength = Integer.parseInt(request.getParameter("menuLength"));
				for(int i = 0; i < menuLength; i++) {
					int menuID = Integer.parseInt(request.getParameter("menuID"+i));
					String updateMenuName = request.getParameter("updateMenuName"+menuID);
					updateMenuName = SecurityUtils.XSSCheck(updateMenuName);
					int updateMenuPrice= Integer.parseInt(request.getParameter("updateMenuPrice"+menuID));
					int result = StoreMenuDAO.getInstance().update(new StoreMenuDTO(menuID, updateMenuName, updateMenuPrice, storeID));
				}
				if((request.getParameter("addedMenuName") != null && !(request.getParameter("addedMenuName").equals("")))
						|| (request.getParameter("addedMenuPrice") !=null && !(request.getParameter("addedMenuPrice").equals("")))
						) {
					String menuName = request.getParameter("addedMenuName");
					menuName = SecurityUtils.XSSCheck(menuName);
					int menuPrice = Integer.parseInt(request.getParameter("addedMenuPrice"));
					int result = StoreMenuDAO.getInstance().insert(new StoreMenuDTO(0, menuName, menuPrice, storeID));
				}
				
				response.sendRedirect("/view.store?storeID="+storeID);
			}
		}catch(Exception e){
			e.printStackTrace();
			response.sendRedirect("/error.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
