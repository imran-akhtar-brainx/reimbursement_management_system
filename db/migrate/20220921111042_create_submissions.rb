class CreateSubmissions < ActiveRecord::Migration[7.0]
  def change
    create_table :submissions do |t|
      t.belongs_to :user
      t.belongs_to :form
      t.json :data
      t.timestamps
    end
  end
end