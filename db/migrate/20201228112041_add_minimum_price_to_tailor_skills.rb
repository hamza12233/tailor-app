class AddMinimumPriceToTailorSkills < ActiveRecord::Migration[6.0]
  def change
    add_column :tailor_skills, :cost, :decimal, null: false, default: 0
  end
end
