class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :status, default: false

      t.timestamps null: false
    end
  end
end
