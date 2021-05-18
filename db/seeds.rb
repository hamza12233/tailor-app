# frozen_string_literal: true

SKILLS_FOR_MEN =
  [
    'Casual Pajama', 'Jeans', 'Dress Pant', 'Formal Shirts', 'Formal Suites',
    'Formal Waist Coat', 'Casual Shirts', 'Kurtas', 'Nightwear',
    'Sherwani', 'Waistcoat', 'Coat'
  ].freeze

SKILLS_FOR_WOMEN = [
  'Ethnic Kurti', 'Shalwar Kameez', 'Bridal Wear', 'Frok', 'Lehnga', 'Plazo',
  'Abaya', 'Maxy', 'Jumpsuit', 'Sharara', 'Gharara', 'Skirts', 'Gawn', 'Trousars', 'Shirts', 'Pents'
].freeze

SKILLS_FOR_KIDS = [
  'Shirts', 'Trousers', 'Frocks', 'Jumpsuits', 'Dresses', 'Nightwear'
].freeze

CATEGORIES = [
  { name: 'men' },
  { name: 'women' },
  { name: 'kids' }
].freeze

STANDARD_FIELDS = [
  { name: 'height', gender: 'both', unit: 'feet' },
  { name: 'front_shoulder_width', gender: 'women', unit: 'inches' },
  { name: 'back_shoulder_width', gender: 'women', unit: 'inches' },
  { name: 'shoulder_to_neck', gender: 'women', unit: 'inches' },
  { name: 'shoulder_to_elbow', gender: 'women', unit: 'inches' },
  { name: 'elbow_to_wrist', gender: 'women', unit: 'inches' },
  { name: 'bust_round', gender: 'women', unit: 'inches' },
  { name: 'wrist', gender: 'both', unit: 'inches' },
  { name: 'waist', gender: 'both', unit: 'inches' },
  { name: 'high_hip_round', gender: 'women', unit: 'inches' },
  { name: 'hip', gender: 'both', unit: 'inches' },
  { name: 'distance_from_nape_to_waist', gender: 'women', unit: 'inches' },
  { name: 'armhole_depth', gender: 'women', unit: 'inches' },
  { name: 'shoulder_length', gender: 'women', unit: 'inches' },
  { name: 'shoulder_point_to_point', gender: 'women', unit: 'inches' },
  { name: 'bicep', gender: 'both', unit: 'inches' },
  { name: 'elbow_round', gender: 'women', unit: 'inches' },
  { name: 'dress_length', gender: 'women', unit: 'inches' },
  { name: 'waist_to_knee_length', gender: 'women', unit: 'inches' },
  { name: 'nape_to_bust_point', gender: 'women', unit: 'inches' },
  { name: 'sleeve_length', gender: 'both', unit: 'inches' },
  { name: 'bottom_waist', gender: 'both', unit: 'inches' },
  { name: 'bottom_length', gender: 'both', unit: 'inches' },
  { name: 'out_seam', gender: 'both', unit: 'inches' },
  { name: 'in_seam', gender: 'both', unit: 'inches' },
  { name: 'weight', gender: 'both', unit: 'kg' },
  { name: 'armlength', gender: 'both', unit: 'inches' },
  { name: 'shoulder_width', gender: 'both', unit: 'inches' },
  { name: 'collar_size', gender: 'men', unit: 'inches' },
  { name: 'chest', gender: 'both', unit: 'inches' },
  { name: 'shirt_length', gender: 'men', unit: 'inches' }
].freeze

CATEGORIES.each do |category|
  Category.find_or_create_by(category)
end

SKILLS_FOR_MEN.each do |skill|
  Skill.find_or_create_by(category_id: Category.men_category.id, name: skill)
end

SKILLS_FOR_WOMEN.each do |skill|
  Skill.find_or_create_by(category_id: Category.women_category.id, name: skill)
end

SKILLS_FOR_KIDS.each do |skill|
  Skill.find_or_create_by(category_id: Category.kids_category.id, name: skill)
end

STANDARD_FIELDS.each do |standard_field|
  StandardField.find_or_create_by(name: standard_field[:name].strip, gender: standard_field[:gender], unit: standard_field[:unit])
end
