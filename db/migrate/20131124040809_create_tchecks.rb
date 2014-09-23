class CreateTchecks < ActiveRecord::Migration
  def change
    create_table :tchecks do |t|
      t.string :date_buy
      t.string :name
      t.string :buy_point
      t.string :phone_number
      t.string :number_check

      t.timestamps
    end
  end
end
