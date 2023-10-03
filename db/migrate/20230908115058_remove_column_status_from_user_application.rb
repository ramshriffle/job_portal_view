class RemoveColumnStatusFromUserApplication < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_applications, :status, :string
  end
end
