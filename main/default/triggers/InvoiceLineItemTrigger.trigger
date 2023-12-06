trigger InvoiceLineItemTrigger on Invoice_Line_Item__c (after insert, after delete) {
    InvoiceLineItemTriggerHandler handler = new InvoiceLineItemTriggerHandler();
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            handler.run(TriggerHandler.TriggerEvent.AFTER_INSERT, Trigger.new, null);
        } else if (Trigger.isDelete) {
            handler.run(TriggerHandler.TriggerEvent.AFTER_DELETE, null, Trigger.oldMap);
        }
    }
}