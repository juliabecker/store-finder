# frozen_string_literal: true

module Salesforce
  class SyncronizeRecords
    class << self
      QUERY_STRING = "SELECT Id, Name, POS_Street__c, POS_City__c, POS_ZIP__c, POS_Country__c, POS_State__c, POS_Phone__c, Dealer_Latitude__c, Dealer_Longitude__c FROM Account WHERE E_Shop_Dealer__c = 'Dealer and Point of Sale'"

      def run
        if Dealer.count == 0
          all_dealer_data = Salesforce::Api.salesforce_client.query QUERY_STRING

          save_dealers(all_dealer_data) if all_dealer_data
        end
      end

      private

      def save_dealers(dealer_data)
        dealer_data.each do |dealer|
          unless Dealer.exists?(salesforce_id: dealer.Id)
            Dealer.create(
              salesforce_id: dealer.Id,
              name: dealer.Name,
              street: dealer.POS_Street__c,
              city: dealer.POS_City__c,
              zip: dealer.POS_ZIP__c,
              country: dealer.POS_Country__c,
              state: dealer.POS_State__c,
              phone: dealer.POS_Phone__c,
              latitude: dealer.Dealer_Latitude__c,
              longitude: dealer.Dealer_Longitude__c,
            ).save
          end
        end
      end
    end
  end
end
