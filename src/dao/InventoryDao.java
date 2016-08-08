package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import connection.DbConnection;

public class InventoryDao {
	Connection con=DbConnection.getConnection();

	public ArrayList<ArrayList<String>> searchArticles(String store, String skuString) {
		ArrayList<ArrayList<String>> articleInfo=new ArrayList<ArrayList<String>>();
		ArrayList<String> articleInforList=new ArrayList<String>();
		try{
			PreparedStatement getInfoForStoreAndArticle=null;
			ResultSet articleAndStoreResult=null;
			System.out.println("Stroe in dao"+store);
			ArrayList<String> skuList=new ArrayList<String>();
			for(String sku:skuString.split(","))
			{
				if(!skuList.contains(sku))
				skuList.add(sku);
			}
			if(store.equalsIgnoreCase("ALL"))
			{
				System.out.println("---All----");
				for(String sku:skuList)
				{
				getInfoForStoreAndArticle=con.prepareStatement(InventoryQueries.getInfoForAllStoreAndArticle);
				getInfoForStoreAndArticle.setString(1, sku);
				articleAndStoreResult=getInfoForStoreAndArticle.executeQuery();
				while(articleAndStoreResult.next())
				{
					articleInforList=new ArrayList<String>();
					articleInforList.add(articleAndStoreResult.getString("store"));
					articleInforList.add(articleAndStoreResult.getString("sku"));
					articleInforList.add(articleAndStoreResult.getString("description"));
					articleInforList.add(articleAndStoreResult.getString("status"));
					articleInforList.add(articleAndStoreResult.getString("onhand"));
					articleInforList.add(articleAndStoreResult.getString("ordered"));
					articleInforList.add(articleAndStoreResult.getString("displayprice"));
					articleInforList.add(articleAndStoreResult.getString("saveprice"));
					articleInforList.add(articleAndStoreResult.getString("wasprice"));
					articleInforList.add(articleAndStoreResult.getString("lastupdated"));
					articleInfo.add(articleInforList);
				}
				
				}
			}
			else
			{
				for(String sku:skuList)
				{
					getInfoForStoreAndArticle=con.prepareStatement(InventoryQueries.getInfoForStoreAndArticle);
					getInfoForStoreAndArticle.setString(1, store);
					getInfoForStoreAndArticle.setString(2, sku);
					articleAndStoreResult=getInfoForStoreAndArticle.executeQuery();
					if(articleAndStoreResult.next())
					{
						articleInforList=new ArrayList<String>();
						articleInforList.add(articleAndStoreResult.getString("store"));
						articleInforList.add(articleAndStoreResult.getString("sku"));
						articleInforList.add(articleAndStoreResult.getString("description"));
						articleInforList.add(articleAndStoreResult.getString("status"));
						articleInforList.add(articleAndStoreResult.getString("onhand"));
						articleInforList.add(articleAndStoreResult.getString("ordered"));
						articleInforList.add(articleAndStoreResult.getString("displayprice"));
						articleInforList.add(articleAndStoreResult.getString("saveprice"));
						articleInforList.add(articleAndStoreResult.getString("wasprice"));
						articleInforList.add(articleAndStoreResult.getString("lastupdated"));
						articleInfo.add(articleInforList);
					}
				}
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return articleInfo;
	}

	public ArrayList<String> loadStores() {
		ArrayList<String> stores=new ArrayList<String>();
		try{
			PreparedStatement loadStores=con.prepareStatement(InventoryQueries.loadStores);
			ResultSet loadStoresResult=loadStores.executeQuery();
			while(loadStoresResult.next())
			{
				stores.add(loadStoresResult.getString("store"));
			}
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return stores;
	}
	
}
