class AddColumnToSubmissions < ActiveRecord::Migration[7.0]
  def change
    add_column :submissions, :status, :integer, default: 0
    add_column :submissions, :approved_by, :string
    # add_column :submissions, :total, :integer, default: 0
  end
end
