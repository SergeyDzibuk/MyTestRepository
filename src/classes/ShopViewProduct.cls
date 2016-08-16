public with sharing class ShopViewProduct {
   
    private final Price__c Add;
    private ApexPages.StandardController controller;
    public ShopViewProduct(ApexPages.StandardController controller)
    {
        this.Add = (Price__c)controller.getRecord();
    }
    
    public PageReference save()
    {	

        try
        {	
            upsert(Add);
            
        } catch(System.DMLException e) {
        	ApexPages.addMessages(e);
        	return null;
    		}
        System.debug('! products: ' + products);
        PageReference newpage = new PageReference(System.currentPageReference().getURL());
        newpage.setRedirect(true); return newpage;

    }
    
    public List<Price__c> products;
    
    public List<Price__c> getProducts() {
        if(products == null) {
            products = [SELECT Name, Name__c, Price__c, Number__c,
                        Type__c, Added_date__c, Release_date__c, in_stock__c FROM Price__c];
        }
        
        return products;
    }

    public String selectedName {get; set;}
    
    public PageReference del()
		{	
            try{

                   for (Integer i=0; i<products.size(); i++) 
                    {

                    if(selectedName == products[i].Name)
                    	{
                        delete products[i];
                        products.remove(i);
                    	break;
                        }    
                	}
            } catch(System.DMLException e) {
        	ApexPages.addMessages(e);
        	return null;
    		}
           return null;
		}
   
    public boolean on_notfound {get; set;}
    public boolean table_result {get; set;}
    public boolean on_close {get; set;}
    public boolean openSearch {get; set;}
    public String SearchName {get; set;}
    public String LikeName {get; set;}
    public Date SearchAdd_date {get; set;}
    public Date DateS {get; set;}
    public String NotFound {get;set;}
    public List<Price__c> searchResult {get; set;}   
    
	public PageReference search()
		{	
            try{
                searchResult = new List<Price__c>();
            	LikeName = '%'+SearchName+'%';
            	DateS = SearchAdd_date;
                openSearch = true;
                table_result = true;
                NotFound = null;
                on_notfound = false;
               	    for (Integer i=0; i<products.size(); i++) 
                    {

                        if (SearchName != null && SearchAdd_date != null)
                    	{
                        	searchResult = [SELECT Name, Name__c, Price__c, Number__c,
                        	Type__c, Added_date__c, Release_date__c, in_stock__c FROM Price__c WHERE Name__c LIKE :LikeName AND Added_date__c=:DateS];      		
                            break;
                        } else if (SearchName != null)
                        			{
                                		searchResult = [SELECT Name, Name__c, Price__c, Number__c,
                        				Type__c, Added_date__c, Release_date__c, in_stock__c FROM Price__c WHERE Name__c LIKE :LikeName];
                                       	break;
                                    } else if (SearchAdd_date != null)
                                    			{
                                        			searchResult = [SELECT Name, Name__c, Price__c, Number__c,
                        							Type__c, Added_date__c, Release_date__c, in_stock__c FROM Price__c WHERE Added_date__c=:DateS];
                                                    break;	
                                                }  
                	}
                								if (searchResult.isEmpty())
                                                		{
															table_result = false;
                                                            on_notfound = true;
                											NotFound = 'Nothing Found';
                                                   
                                                		}
                
            } catch(System.DMLException e) {
        	ApexPages.addMessages(e);
        	return null;
    		}
            SearchAdd_date=null;
            SearchName=null;
            on_close = true;
    	return null;
		}
    
    public PageReference close() 
    {	
     
        PageReference newpage = new PageReference(System.currentPageReference().getURL());
        newpage.setRedirect(true);
        on_close = false;
        table_result = false;
        on_notfound = false;
        openSearch = false;
        return newpage;
        
    }       	    
    
}