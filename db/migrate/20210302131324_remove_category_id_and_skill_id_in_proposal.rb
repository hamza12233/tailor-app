class RemoveCategoryIdAndSkillIdInProposal < ActiveRecord::Migration[6.0]
  def change
    remove_column :proposals, :category_ids, :bigint
    remove_column :proposals, :skill_ids, :bigint
    remove_column :proposals, :size_profile_id, :bigint
  end
end
