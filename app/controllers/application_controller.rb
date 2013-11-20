class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

	before_action :connect_to_salesforce

	private

	def connect_to_salesforce
		@client = Databasedotcom::Client.new
		@client.authenticate(username: ENV['SF_USERNAME'], password: ENV['SF_PASSWORD'])
		@client.debugging = true
	end
end
