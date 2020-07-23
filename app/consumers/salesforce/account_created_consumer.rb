# frozen_string_literal: true

require 'faye'

module Salesforce
  class AccountCreatedConsumer
    TOPIC_NAME = "CreatedAccounts"
    # replay_value is required to subscribe to salesforce push topic;
    # -2 requests events from last 24 hours 
    REPLAY_VALUE = -2

    def initialize
      Salesforce::Api.create_updated_topic unless Salesforce::Api.topic_exists?(TOPIC_NAME)
    end

    def run
      EM.run do
        Salesforce::Api.subscribe_to_topic(TOPIC_NAME, REPLAY_VALUE) do |message|
          save_dealer(message["sobject"])
        end
      end
    end
  end

  private

  def save_dealer(account_event_data)
    Dealer.create(
      name: account_event_data["Name"],
      street: account_event_data["POS_Street__c"],
      city: account_event_data["POS_City__c"],
      state: account_event_data["POS_State__c"],
      zip: account_event_data["POS_ZIP__c"],
      country: account_event_data["POS_Country__c"],
      phone: account_event_data["POS_Phone__c"],
      latitude: account_event_data["Dealer_Latitude__c"],
      longitude: account_event_data["Dealer_Longitude__c"],
    ).save
  end
end
