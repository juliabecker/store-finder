namespace :salesforce do
  desc "Run consumer to fetch newly created accountdealer records from Salesforce"
  task run_created_consumer: :environment do
    Salesforce::AccountCreatedConsumer.new.run
  end
end
