class CreateChecks < ActiveRecord::Migration
  def change
    create_table :checks do |t|
      t.string :date_buy
      t.string :name
      t.string :buy_point
      t.string :phone_number
      t.string :number_check
      t.string :winner

      t.timestamps
    end
  end
end
