trigger accountEmailPhonePopulate on Account (after insert) {
    
    /*Whenever an account’s email or phone is changed populate all related contacts email 
    and phone numbers with the account’s if the contact’s email and phone number is blank*/
    
    List<Account> newAcc = Trigger.new;
    List<Account> oldAcc = Trigger.old;
    List<Account> needsUpdate = New List<Account>();
    
    //loop through and find accounts with changes
    for(Integer i = 0; i < newAcc.size(); i++)
    {
        if(newAcc[i].Phone != oldAcc[i].Phone || newAcc[i].Email__c != oldAcc[i].Email__c)
        {
            needsUpdate.add(newAcc[i]);
        }

    }

    //Pull all contacts that have empty values
    List<Contact> holdCont = [Select Id, Name, Email, Phone From Contact 
                                Where AccountID In :needsUpdate AND 
                                (Phone = Null Or Phone = '' Or Email = Null or Email = '')];


    //loop through
    for(Account a: needsUpdate)
    {
        for(Contact c: holdCont)
        {
            if(c.AccountId == a.Id)
            {   
                //make changes to related contacts and if updated remove from iterative list
                if(c.Phone != null || c.Phone != '')
                {
                    c.Phone = a.Phone;
                }

                if(c.Email != null || c.Email != '')
                {
                    c.Email = a.Email__c;
                }                
            }
        }
    }

    update holdCont;
    
        
}
