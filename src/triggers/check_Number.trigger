trigger check_Number on Price__c (before insert, before update) {
    for(Price__c a : Trigger.new)
    {
        Boolean checkboxValue = a.in_stock__c;
        if(a.Number__c <= 0)
        {
            a.in_stock__c = false;
        } else
        {
            a.in_stock__c = true;
        }
    }

}