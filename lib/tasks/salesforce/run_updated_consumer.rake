namespace :salesforce do
  desc "Run consumer to fetch newly updated account records from Salesforce"
  task run_updated_consumer: :environment do
    Salesforce::AccountUpdatedConsumer.new.run
  end
end
