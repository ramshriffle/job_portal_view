class CreateUserApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :user_applications do |t|
      t.string :status
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
