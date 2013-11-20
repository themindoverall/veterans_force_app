class PeopleController < ApplicationController
	def index
		@client.materialize("Contact")

		@contacts = @client.query('SELECT Id, Name, Branch_of_Service__c FROM Contact WHERE Branch_of_Service__c != NULL')

		contact_ids = @contacts.collect{|c| "\'#{c.Id}\'"}

		detail_list = @client.query("SELECT Id, Contact__c, OEF_OIF__c, Start_Date__c, End_Date__c FROM Detailed_Deployment_Information__c WHERE Contact__c IN (#{contact_ids.join(',')})")

		@details = {}

		detail_list.each do |detail|
			@details[detail['Contact__c']] = detail
		end
	end
end