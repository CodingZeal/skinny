class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :firstname
      t.string :middlename
      t.string :lastname

      t.timestamps
    end
  end
end
