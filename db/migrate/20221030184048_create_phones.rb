class CreatePhones < ActiveRecord::Migration[7.0]
  def change
    create_table :phones do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name
      t.string :type
      t.text :problem
      t.string :state

      t.timestamps
    end
  end
end
