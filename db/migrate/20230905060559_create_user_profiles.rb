class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.string :f_name
      t.string :l_name
      t.string :skills
      t.string :experience
      t.string :education
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
