class Author < ApplicationRecord
  has_many :posts, dependent: :nullify
  has_one :detail, dependent: :destroy

  accepts_nested_attributes_for :detail, allow_destroy: true
end
