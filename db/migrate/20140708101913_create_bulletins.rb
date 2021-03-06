class CreateBulletins < ActiveRecord::Migration
  def change
    create_table :bulletins do |t|
      t.string :title, null: false
      t.date :date, null: false
      t.text :content, null: false
      t.attachment :image_path
      t.boolean :send_notify, default: true
      t.integer :condo_id, null: false

      t.timestamps
    end
  end
end

