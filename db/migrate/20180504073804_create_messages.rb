class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :conversation, foreign_key: true
      t.string :message
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
