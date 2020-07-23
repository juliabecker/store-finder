module Salesforce
  class SyncronizeRecords
    class << self

      def update_new_records
        new_dealer_data = get_dealer_data

        save_dealers(new_dealer_data) if new_dealer_data
      end

      def update_deleted_records
        deleted_dealer_data = client.get_deleted

        delete_dealers(deleted_dealer_data) if deleted_dealer_data
      end

      private

      def client
        @client ||= Salesforce::Api.new
      end

      def last_updated_timestamp
        Dealer.maximum(:updated_at)
      end

      def save_dealers(dealer_data)
        dealer_data.each do |dealer|
          unless Dealer.exists?(salesforce_id: dealer.Id)
            save_dealer(dealer)
          end
        end
      end

      def save_dealer(dealer)
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

      def get_dealer_data
        # No records have been loaded yet, need to fetch all
        if Dealer.count == 0
          puts "all dealers loaded"
          return client.get_all_dealer_data
        else
          puts "need to fetch updates"
          return client.get_updated(last_updated_timestamp, Time.now)
        end
      end

      def delete_dealers(deleted_dealers)
        deleted_dealers.each do |dealer|
          Dealer.find(dealer.Id).delete
        end
      end
    end
  end
end
