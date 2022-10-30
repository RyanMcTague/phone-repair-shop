class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone_type, null: false
      t.text :problem, null: false
      t.string :state
      t.index [:user_id, :name], unique: true

      t.timestamps
    end
  end
end
