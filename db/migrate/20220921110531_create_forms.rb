class CreateForms < ActiveRecord::Migration[7.0]
  def change
    create_table :forms do |t|
      t.string :_type
      t.json :data
      t.timestamps
    end
  end
end
