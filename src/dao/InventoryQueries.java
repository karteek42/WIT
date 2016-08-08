package dao;

public interface InventoryQueries {

	String getInfoForStoreAndArticle = "select * from inventory where store=? and sku=?";
	String getInfoForAllStoreAndArticle="select * from inventory where sku=? order by store";
	String loadStores = "select distinct store from inventory";

}
