public with sharing class InvoiceLineItemTriggerHandler extends TriggerHandler {
    private void rollUpLineItemsToInvoice(Set<Id> invoiceIds) {
        List<AggregateResult> results = [
        SELECT Invoice__c, COUNT(Id) itemCount
        FROM Invoice_Line_Item__c
        WHERE Invoice__c IN :invoiceIds
        GROUP BY Invoice__c
    ];
        Map<Id, AggregateResult> itemCountMap = new Map<Id, AggregateResult>();

        for (AggregateResult ar : results) {
            Id invoiceId = (Id) ar.get('Invoice__c');
            itemCountMap.put(invoiceId, ar);
        }

        List<Invoice__c> invoicesToUpdate = new List<Invoice__c>();

        for (Id invoiceId : invoiceIds) {
            AggregateResult ar = itemCountMap.get(invoiceId);
            if(ar != null) {
                Invoice__c invoice = new Invoice__c(Id = invoiceId);
                invoice.Amount_of_Line_Items__c = (Integer)ar.get('itemCount');
                invoicesToUpdate.add(invoice);
            } else {
                Invoice__c invoice = new Invoice__c(Id = invoiceId);
                invoice.Amount_of_Line_Items__c = 0;
                invoicesToUpdate.add(invoice);
            }
        }
        if(invoicesToUpdate.size() > 0){
            update invoicesToUpdate;
        }
    }
    public override void afterInsert(List<SObject> newItems) {
        Set<Id> invoiceIds = new Set<Id>();
        for (SObject obj : newItems) {
            Invoice_Line_Item__c ili = (Invoice_Line_Item__c)obj;
            invoiceIds.add(ili.Invoice__c);
        }
        rollUpLineItemsToInvoice(invoiceIds);
    }

    public override void afterDelete(Map<Id, SObject> oldMap) {
        Set<Id> invoiceIds = new Set<Id>();
        for (SObject obj : oldMap.values()) {
            Invoice_Line_Item__c ili = (Invoice_Line_Item__c)obj;
            invoiceIds.add(ili.Invoice__c);
        }
        rollUpLineItemsToInvoice(invoiceIds);
    }
}