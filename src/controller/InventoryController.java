package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import dao.InventoryDao;

/**
 * Servlet implementation class InventoryController
 */
@WebServlet("/InventoryController")
public class InventoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InventoryController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("sevlet path ");
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String servletPath = request.getServletPath();
		String operation = request.getParameter("operation");
		InventoryDao inventoryDao=new InventoryDao();
		System.out.println("sevlet path "+servletPath + " ************");
		System.out.println("operation "+operation + " ************");
		if("searchArticles".equalsIgnoreCase(operation))
		{
			String store=request.getParameter("store");
			String sku=request.getParameter("sku");
			System.out.println("store: "+store+", sku: "+sku);
			ArrayList<ArrayList<String>> articleInfo=new ArrayList<ArrayList<String>>();
			articleInfo=inventoryDao.searchArticles(store,sku);
			Gson json=new Gson();
			HashMap map=new HashMap();
			map.put("articleInfo", articleInfo);
			System.out.println("articleInfo :"+articleInfo);
			String jsonStr=json.toJson(map);
			response.getWriter().write(jsonStr);
		}
		else if("loadStores".equalsIgnoreCase(operation))
		{
			ArrayList<String> stores=new ArrayList<String>();
			stores=inventoryDao.loadStores();
			Gson json=new Gson();
			HashMap map=new HashMap();
			map.put("stores", stores);
			System.out.println("stores :"+stores);
			String jsonStr=json.toJson(map);
			response.getWriter().write(jsonStr);
		}
	}

}
