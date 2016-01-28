class AddParentIdToTag < ActiveRecord::Migration
  def change
    change_table :tags do |t|
      t.integer :parent_id
    end
  end
end
