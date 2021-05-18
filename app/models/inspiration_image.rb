class InspirationImage < ApplicationRecord
  mount_uploader :image, InspirationImagesUploader

  ATTRIBUTES_WHITELIST = [
    :id,
    :skill_id,
    :image,
  ].freeze
  belongs_to :skill
  belongs_to :proposal, optional: true
end
