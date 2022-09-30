class AddColumnToSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_column :submissions, :status, :string, default: "pending"
    add_column :submissions, :approved_by, :string
  end
end
