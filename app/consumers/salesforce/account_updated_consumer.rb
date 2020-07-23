# frozen_string_literal: true

require 'faye'

module Salesforce
  class AccountUpdatedConsumer
    TOPIC_NAME = "UpdatedAccounts"
    # replay_value is required to subscribe to salesforce push topic;
    # -2 requests events from last 24 hours 
    REPLAY_VALUE = -2

    def initialize
      Salesforce::Api.create_updated_topic unless Salesforce::Api.topic_exists?(TOPIC_NAME)
    end

    def run
      EM.run do
        Salesforce::Api.subscribe_to_topic(TOPIC_NAME, REPLAY_VALUE) do |message|
          update_dealer(message["sobject"])
        end
      end
    end
  end

  private

  def update_dealer(account_event_data)
    salesforce_id = account_event_data["Id"]

    dealer = Dealer.find_by(salesforce_id)

    if dealer
      fields_to_update = {
        name: account_event_data["Name"],
        street: account_event_data["POS_Street__c"],
        city: account_event_data["POS_City__c"],
        state: account_event_data["POS_State__c"],
        zip: account_event_data["POS_ZIP__c"],
        country: account_event_data["POS_Country__c"],
        phone: account_event_data["POS_Phone__c"],
        latitude: account_event_data["Dealer_Latitude__c"],
        longitude: account_event_data["Dealer_Longitude__c"],
      }

      dealer.update_attributes(fields_to_update)
    end
  end
end
