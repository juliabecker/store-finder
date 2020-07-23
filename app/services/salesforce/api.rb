require 'restforce'

module Salesforce
  class Api 

    cattr_reader :salesforce_client, instance_accessor: false do
      client = Restforce.new(
        api_version: ::SALESFORCE_CONFIG["api_version"],
        host: ::SALESFORCE_CONFIG["host"],
        username: ::SALESFORCE_CONFIG["username"],
        password: ::SALESFORCE_CONFIG["password"],
        client_id: ::SALESFORCE_CONFIG["client_id"],
        client_secret: ::SALESFORCE_CONFIG["client_secret"],
      )

      client.authenticate!

      client
    end

    def self.query(query_string)
      salesforce_client.query query_string
    end

    def self.create_deleted_topic
      salesforce_client.create!("PushTopic",
                     ApiVersion: SALESFORCE_CONFIG["api_version"],
                     Name: "DeletedAccounts",
                     Description: "Ids of deleted account records",
                     NotifyForOperationDelete: true,
                     NotifyForFields: "All",
                     Query: "SELECT Id FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'")
    end

    def self.create_updated_topic
      salesforce_client.create!("PushTopic",
                                ApiVersion: SALESFORCE_CONFIG["api_version"],
                                Name: "UpdatedAccounts",
                                Description: "All updated account records",
                                NotifyForOperationUpdate: true,
                                NotifyForFields: "Select",
                                Query: "SELECT Id, Name, POS_Street__c, POS_City__c, POS_ZIP__c, POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, Dealer_Longitude__c FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'")
    end

    def self.create_created_topic
      salesforce_client.create!("PushTopic",
                                ApiVersion: SALESFORCE_CONFIG["api_version"],
                                Name: "CreatedAccounts",
                                Description: "All created account records",
                                NotifyForOperationCreate: true,
                                NotifyForFields: "Select",
                                Query: "SELECT Id, Name, POS_Street__c, POS_City__c, POS_ZIP__c, POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, Dealer_Longitude__c FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'")
    end

    def self.topic_exists?(topic_name)
      all_topics= salesforce_client.query 'SELECT name FROM pushtopic'

      all_topics.map(&:Name).include?(topic_name)
    end

    def self.subscribe_to_topic(name, replay_value)
      salesforce_client.subscription "/topic/#{name}", replay: replay_value do |message|
        yield(message)
      end
    end
  end
end
