@isTest
private class TestController {

    public static testMethod void testSave(){
        List<Price__c> products = new List<Price__c>{};
        Price__c Add = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert(Add);
        ApexPages.StandardController s = new ApexPages.StandardController(Add);
        ShopViewProduct controller = new ShopViewProduct(s);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        controller.save();
        System.assertEquals('product', Add.Name__c);
        System.assertEquals(99, Add.Price__c);
        System.assertEquals(99, Add.Number__c);
        System.assertEquals('Type3', Add.Type__c);
        System.assertEquals(Date.today(), Add.Added_date__c);
        System.assertEquals(Date.today()-1, Add.Release_date__c);
        System.assertEquals(true, Add.in_stock__c);
    }
    
    public static testMethod void testGet() {
        List<Price__c> products = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
		/*products = [SELECT Name, Name__c, Price__c, Number__c,
                        Type__c, Added_date__c, Release_date__c, in_stock__c FROM Price__c];*/

        controller.getProducts();
        System.assert(controller.products.size()>0);
        
    }
    
    public static testMethod void testDel() {
        List<Price__c> products = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        delete p;
        controller.getProducts();
        controller.selectedName=p.Name;
       	controller.del();
      	System.assert(controller.products.size()==0);
    }
      
    public static testMethod void testSearch1() {
        List<Price__c> searchResult = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        controller.getProducts();
        controller.SearchName = 'product';
		controller.SearchAdd_date = Date.today();
		controller.search();
		System.assert(controller.searchResult.size()>0);        
    }
    
    public static testMethod void testSearch2() {
        List<Price__c> searchResult = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        controller.getProducts();
        controller.SearchName = 'product';
		controller.SearchAdd_date = null;
		controller.search();
		System.assert(controller.searchResult.size()>0);        
    }
    
    public static testMethod void testSearch3() {
        List<Price__c> searchResult = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        controller.getProducts();
        controller.SearchName = null;
		controller.SearchAdd_date = Date.today();
		controller.search();
		System.assert(controller.searchResult.size()>0);        
    }
  
	public static testMethod void testClose() {
        List<Price__c> searchResult = new List<Price__c>{};
        Price__c p = new Price__c (Name__c='product', Price__c=99, Number__c=99, Type__c='Type3', Added_date__c=Date.today(), Release_date__c=Date.today()-1, in_stock__c=true);
        upsert p;
        ApexPages.StandardController g = new ApexPages.StandardController(p);
        ShopViewProduct controller = new ShopViewProduct(g);
        PageReference pageRef = Page.prices_visualforce;
        Test.setCurrentPageReference(pageRef);
        controller.getProducts();
		controller.close();
		System.assertEquals(false, controller.on_close);
        System.assertEquals(false, controller.table_result);
        System.assertEquals(false, controller.on_notfound);
		System.assertEquals(false, controller.openSearch);        
    }
}