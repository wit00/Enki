class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.text :question
      t.text :answer
      t.integer :score
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
