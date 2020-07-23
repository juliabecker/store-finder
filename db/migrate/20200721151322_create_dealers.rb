class CreateDealers < ActiveRecord::Migration[6.0]
  def change
    create_table :dealers do |t|
      t.string :salesforce_id
      t.string :name
      t.string :street
      t.string :city
      t.string :zip
      t.string :country
      t.string :state
      t.string :phone
      t.decimal :latitude
      t.decimal :longitude

      t.timestamps
    end
  end
end
