public abstract class TriggerHandler {
    public virtual void afterDelete(Map<Id, SObject> oldMap){}
    public virtual void afterInsert(List<SObject> newItems){}
    public virtual void beforeInsert(List<SObject> newItems){}
    public virtual void beforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap){}
    public virtual void afterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap){}
    public virtual void beforeDelete(Map<Id, SObject> oldMap){}
    public virtual void afterUndelete(List<SObject> restoredItems){}

    
    public void run(TriggerEvent event, List<SObject> newItems, Map<Id, SObject> oldMap){
        switch on event {
            when BEFORE_INSERT {
                beforeInsert(newItems);
            }
            when AFTER_INSERT {
                afterInsert(newItems);
            }
            when BEFORE_UPDATE {
                beforeUpdate(oldMap, (Map<Id, SObject>) Trigger.newMap);
            }
            when AFTER_UPDATE {
                afterUpdate(oldMap, (Map<Id, SObject>) Trigger.newMap);
            }
            when BEFORE_DELETE {
                beforeDelete(oldMap);
            }
            when AFTER_DELETE {
                afterDelete(oldMap);
            }
            when AFTER_UNDELETE {
                afterUndelete(newItems);
            }
        }
    }
    public enum TriggerEvent {
        BEFORE_INSERT, AFTER_INSERT,
        BEFORE_UPDATE, AFTER_UPDATE,
        BEFORE_DELETE, AFTER_DELETE,
        AFTER_UNDELETE
    }
}