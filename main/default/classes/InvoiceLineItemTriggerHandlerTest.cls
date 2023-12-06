
@isTest
private class InvoiceLineItemTriggerHandlerTest {

    @isTest
    static void testAfterInsert() {
        Invoice__c invoice = new Invoice__c();
        insert invoice;

        Test.startTest();

        Invoice_Line_Item__c lineItem = new Invoice_Line_Item__c(Invoice__c = invoice.Id);
        insert lineItem;

        Test.stopTest();

        Invoice__c updatedInvoice = [SELECT Amount_of_Line_Items__c FROM Invoice__c WHERE Id=:invoice.Id];
        Assert.areEqual(1, updatedInvoice.Amount_of_Line_Items__c, 'The count of line items should be rolled up to the Invoice.');
    }

    @isTest
    static void testAfterDelete() {

        Invoice__c invoice = new Invoice__c();
        insert invoice;

        Invoice_Line_Item__c lineItem1 = new Invoice_Line_Item__c(Invoice__c = invoice.Id);
        Invoice_Line_Item__c lineItem2 = new Invoice_Line_Item__c(Invoice__c = invoice.Id);
        insert new List<Invoice_Line_Item__c>{ lineItem1, lineItem2 };

        Test.startTest();

        delete lineItem1;

        Test.stopTest();

        Invoice__c updatedInvoice = [SELECT Amount_of_Line_Items__c FROM Invoice__c WHERE Id=:invoice.Id];
        Assert.areEqual(1, updatedInvoice.Amount_of_Line_Items__c, 'The count of line items should be decremented after deletion.');
    }
}
