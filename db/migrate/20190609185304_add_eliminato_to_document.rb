class AddEliminatoToDocument < ActiveRecord::Migration[5.2]
  def change
    add_column "documents", :eliminato, :boolean
  end
end
