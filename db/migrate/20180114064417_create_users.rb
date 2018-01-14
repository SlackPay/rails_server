class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :receive_address
      t.string :slack_user_name
      t.string :slack_user_id

      t.timestamps
    end
  end
end
