class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :editor_id
      t.string :state
      t.text :content
      t.datetime :published_at

      t.timestamps
    end
    add_index :pages, :editor_id
    add_index :pages, :state
  end
end
