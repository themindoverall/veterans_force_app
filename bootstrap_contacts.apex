List<Contact> newContacts = new List<Contact>();
Contact contact;
String[] firstNames = new String[] {'Cody',
'Melvin',
'Jonna',
'Zandra',
'Ayana',
'Cassi',
'Laquita',
'Lindy',
'Delia',
'Darron',
'Matha',
'Nelle',
'Renee',
'Anastasia',
'Torie',
'Jeffrey',
'Gilberto',
'Risa',
'Mandie',
'Kimberlee',
'Giovanna',
'Bette',
'See',
'Almeta',
'Elida',
'Amada',
'Marica',
'Janis',
'Shawana',
'Colette'};

String[] lastNames = new String[] {'Elliott',
'Greer',
'Herrera',
'Moran',
'Baldwin',
'Simmons',
'Wilson',
'Tyler',
'Griffith',
'Hughes',
'Vega',
'Rodgers',
'Mcbride',
'Mendoza',
'Haynes',
'Thompson',
'Webb',
'Jimenez',
'Cooper',
'Farmer',
'Harris',
'Casey',
'Fields',
'Arnold',
'Norris'};

String[] branches = new String[] {
	'Army',
	'Navy',
	'Marines',
	'Air Force',
	'Coast Guard'
};

String[] ops = new String[] {
	'OEF',
	'OIF',
	'OND'
};

Integer i = 100;
while (i > 0) {
	Integer fnIndex = (Math.random() * firstNames.size()).intValue();
	Integer lnIndex = (Math.random() * lastNames.size()).intValue();
	Integer bIndex = (Math.random() * branches.size()).intValue();
	contact = new Contact(
		FirstName = firstNames[fnIndex],
		LastName = lastNames[lnIndex],
		Branch_of_Service__c = branches[bIndex]
	);

	newContacts.add(contact);
	i -= 1;
}

insert newContacts;

List<Detailed_Deployment_Information__c> newDetails = new List<Detailed_Deployment_Information__c>();

Date today = Date.today();
for (Contact c : newContacts) {
	Integer daysAgoStarted = (Math.random() * 12 * 10 * 30).intValue();
	Integer daysAgoEnded = (Math.random() * daysAgoStarted).intValue();
	Integer opIndex = (Math.random() * ops.size()).intValue();

	Detailed_Deployment_Information__c detail = new Detailed_Deployment_Information__c(
		Contact__c = c.Id,
		Start_Date__c = today.addDays(-daysAgoStarted),
		End_Date__c = today.addDays(-daysAgoEnded),
		OEF_OIF__c = ops[opIndex]
	);
	newDetails.add(detail);
}

insert newDetails;