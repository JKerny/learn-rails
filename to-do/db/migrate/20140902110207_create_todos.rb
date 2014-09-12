class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.text :decription
      t.date :duedate
      t.string :status

      t.timestamps
    end
  end
end
