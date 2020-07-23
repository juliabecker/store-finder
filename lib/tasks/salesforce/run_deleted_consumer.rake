namespace :salesforce do
  desc "Run consumer to fetch newly deleted account records from Salesforce"
  task run_deleted_consumer: :environment do
    Salesforce::AccountDeletedConsumer.new.run
  end
end
