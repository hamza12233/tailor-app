class ChangeExperienceStringToDecimal < ActiveRecord::Migration[6.0]
  def up
    change_column :tailor_skills, :experience, 'decimal USING CAST(experience AS decimal)'
  end
  
  def down
    change_column :tailor_skills, :experience, :string
  end
end
