class SizeProfileField < ApplicationRecord

  ATTRIBUTES_WHITELIST = [
    :id,
    :value,
    :standard_field_id,
    :standard_field_name,
    :user_id,
    :_destroy
  ].freeze

  belongs_to :size_profile
  belongs_to :standard_field
  belongs_to :user

  validates :value, presence: true
  validates :user, uniqueness: { scope: [:standard_field_id, :size_profile_id] }

end
