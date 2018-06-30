class CreateSecretCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :secret_codes do |t|
      t.string :code, null: false, unique: true
      t.string :email
      t.datetime :exp_time
      t.references :user, null: true, unique: true, index: true

      t.timestamps
    end
  end
end
