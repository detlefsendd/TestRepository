trigger accountUpdateOwner on Account (after update) {
    // Send an email to an account Owner whenever a related contact is updated by someone other than the account owner
    List<Account> holdAcc = Trigger.new;
    Id currentId = Userinfo.getUserId();
    
    //Loop through holdAcc
    for(Integer i = 0; i < holdAcc.size(); i++)
    {
        //if the current active user is not the owner
        if(currentId != holdAcc[i].Owner.Id)
        {
            //Create an email and send
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setTargetObjectId(holdAcc[i].Owner.Id);
            mail.setSubject('Owned Account Changed');
            mail.setPlainTextBody(holdAcc[i].Name + ' has been changed by another user. Please check the Account');
            Messaging.sendEmail(new Messaging.Email[] {mail}, false);
        }
    }

}
