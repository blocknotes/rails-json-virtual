class Detail < ApplicationRecord
  belongs_to :author, touch: true
end
