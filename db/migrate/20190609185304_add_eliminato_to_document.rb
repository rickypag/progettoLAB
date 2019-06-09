class AddEliminatoToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column 'document', :eliminato, :boolean
  end
end
