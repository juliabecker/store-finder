# frozen_string_literal: true

require 'faye'

module Salesforce
  class AccountDeletedConsumer
    TOPIC_NAME = "DeletedAccounts"
    # replay_value is required to subscribe to salesforce push topic;
    # -2 requests events from last 24 hours 
    REPLAY_VALUE = -2

    def initialize
      Salesforce::Api.create_deleted_topic unless Salesforce::Api.topic_exists?(TOPIC_NAME)
    end

    def run
      EM.run do
        Salesforce::Api.subscribe_to_topic(TOPIC_NAME, REPLAY_VALUE) do |message|
          salesforce_id = message["sobject"]["Id"]

          dealer = Dealer.find_by(salesforce_id: salesforce_id)

          dealer.delete if dealer
        end
      end
    end
  end
end
