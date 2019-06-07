class AddIndexToStudentsUsername < ActiveRecord::Migration[5.2]
  def change
	add_index :student, :username, unique: true
  end
end
