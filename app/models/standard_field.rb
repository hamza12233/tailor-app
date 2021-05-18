# frozen_string_literal: true

class StandardField < ApplicationRecord
  FOR_GENDER = {
    both: 0,
    men: 1,
    women: 2
  }.freeze

  NAMES = {
    height: 0,
    front_shoulder_width: 1,
    back_shoulder_width: 2,
    shoulder_to_neck: 3,
    shoulder_to_elbow: 4,
    elbow_to_wrist: 5,
    bust_round: 6,
    wrist: 7,
    waist: 8,
    high_hip_round: 9,
    hip: 10,
    distance_from_nape_to_waist: 11,
    armhole_depth: 12,
    shoulder_length: 13,
    shoulder_point_to_point: 14,
    bicep: 15,
    elbow_round: 16,
    dress_length: 17,
    waist_to_knee_length: 18,
    nape_to_bust_point: 19,
    sleeve_length: 20,
    bottom_waist: 21,
    bottom_length: 22,
    out_seam: 23,
    in_seam: 24,
    weight: 25,
    armlength: 26,
    shoulder_width: 27,
    collar_size: 28,
    chest: 29,
    shirt_length: 30
  }.freeze

  UNITS = {
    inches: 0,
    feet: 1,
    kg: 2
  }.freeze

  MEN   = 'men'
  WOMEN = 'women'

  enum gender: FOR_GENDER
  enum name: NAMES
  enum unit: UNITS

  has_many :size_profile_fields
  has_many :order_item_size_profile_fields

  validates :name, presence: true, uniqueness: true
  validates :gender, presence: true
end
