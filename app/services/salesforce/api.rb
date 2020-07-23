require 'restforce'

module Salesforce
  class Api

    def initialize
      @client = Restforce.new(
        api_version: 49.0,
        host: SALESFORCE_CONFIG["host"],
        username: SALESFORCE_CONFIG["username"],
        password: SALESFORCE_CONFIG["password"],
        client_id: SALESFORCE_CONFIG["client_id"],
        client_secret: SALESFORCE_CONFIG["client_secret"],
      )

      @client.authenticate!

      @client
    end

    def get_all_dealer_data
      @client.query "SELECT Id, Name, POS_Street__c, POS_City__c, POS_ZIP__c, POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, Dealer_Longitude__c FROM Account where E_Shop_Dealer__c = 'Dealer and Point of Sale'"
    end

    def get_deleted
      @client.query "SELECT Id FROM Account where E_Shop_Dealer__c = 'Dealer and Point of Sale' AND IsDeleted = true"
    end

    def get_updated(from_timestamp, to_timestamp)
      @client.get_updated('Account', from_timestamp, to_timestamp)
    end
  end
end
