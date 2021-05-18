class CreateInspirationImages < ActiveRecord::Migration[6.0]
  def change
    create_table :inspiration_images do |t|
      t.references :skill, null: false, foreign_key: true
      t.references :proposal, foreign_key: true
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
