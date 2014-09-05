class CreateTechSupports < ActiveRecord::Migration
  def change
    create_table :tech_supports do |t|
      t.string :address
      t.string :phone
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
