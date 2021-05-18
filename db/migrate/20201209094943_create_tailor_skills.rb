class CreateTailorSkills < ActiveRecord::Migration[6.0]
  def change
    create_table :tailor_skills do |t|
      t.string :experience
      t.string :description

      t.references :user, foreign_key: true, on_delete: :cascade
      t.references :skill, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
