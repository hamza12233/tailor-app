class ProposalImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  ATTRIBUTES_WHITELIST = [
    :id,
    :image,
    :proposal_id,
    :_destroy
  ].freeze

  belongs_to :proposal
end
