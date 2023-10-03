class AddColumnStatusToUserApplication < ActiveRecord::Migration[7.0]
  def change
    add_column :user_applications, :status, :string, default: 'applied'
  end
end
