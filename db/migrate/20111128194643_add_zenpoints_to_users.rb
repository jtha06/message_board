class AddZenpointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zenpoints, :integer
  end
end
