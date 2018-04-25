class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :email
      t.string :salary
      t.string :lname

      t.timestamps
    end
  end
end
