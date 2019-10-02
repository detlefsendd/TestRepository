trigger TaskTracker on Task (after insert, after delete) {
    //Maintain a real-time count of the number of tasks on the account

    //if insert add to tracker
   if(Trigger.isInsert)
    {
        List<Task> holdUpdated = Trigger.new;
        List<ID> AccId = New List<ID>();

        for(Task t: holdUpdated)
        {
            AccId.add(t.WhatID);
        }
        
        List<Account> Accs = [Select ID, Name, Tasks__c From Account Where ID In :AccId];
        
        //Loop through accounts incrementing for each that is 
        for(Account a: Accs)
        {
            for(Task t: holdUpdated)
            {
                if(a.Id == t.WhatId)
                {
                    a.Tasks__c++;
                }
            }
        }
    }

    //if delete deincrement tracker
    if(Trigger.isDelete)
    {
        List<Task> holdUpdated = Trigger.old;
        List<ID> AccId = New List<ID>();

        for(Task t: holdUpdated)
        {
            AccId.add(t.WhatID);
        }
        
        List<Account> Accs = [Select ID, Name, Tasks__c From Account Where ID In :AccId];
        
        //Loop through accounts incrementing for each that is 
        for(Account a: Accs)
        {
            for(Task t: holdUpdated)
            {
                if(a.Id == t.WhatId)
                {
                    a.Tasks__c--;
                }
            }
        }
    }
    
    //push the update
    Update Accs;
}
