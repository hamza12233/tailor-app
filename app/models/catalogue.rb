class Catalogue < ApplicationRecord
  mount_uploaders :image, CatalogueImagesUploader

  ATTRIBUTES_WHITELIST = [
    :name,
    :description,
    :price,
    :category_id,
    image:[]
  ].freeze

  belongs_to :category

  def as_json
    super(
      {
        include: {
          category: {}
        }
      }
    )
  end
end
