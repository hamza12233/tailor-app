class ProposalItem < ApplicationRecord
  ATTRIBUTES_WHITELIST =[
    :id,
    :skill_id,
    :proposal_id,
    :category_id,
    :size_profile_id,
    :_destroy
  ].freeze

  belongs_to :proposal
  belongs_to :size_profile, optional: true
  belongs_to :skill
  belongs_to :category

end
