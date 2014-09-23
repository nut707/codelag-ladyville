class AddDateBuyForChecks < ActiveRecord::Migration
  def change
  	add_column :checks, :reg_date, :string
  	add_column :checks, :part_number, :integer
  end
end
