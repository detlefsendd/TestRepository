//Throws an error on NetworkModeration class
//Don't know if this is the correct thought process or if I'm off base

trigger FlagContact on Contact (after insert, after update) {
//Have a flag on the contact if the email is the same as the parent account 
//and a flag if the phone number is the same as the parent account

List<NetworkModeration> flags = new List<NetworkModeration>();
List<Contact> holdCont = Trigger.new;
List<Account> holdAcc = new List<Account>();

for(Contact c: holdCont)
{
    holdAcc.add(c.Account);
}



NetworkModeration nm = new NetworkModeration(EntityId = rec.id, Visibility = 'ModeratorsOnly');
            flags.add(nm);





}
