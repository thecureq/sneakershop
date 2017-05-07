class Brand < ApplicationRecord
  has_many :sneakers
  mount_uploader :logo, LogoUploader
  validates :logo, presence: true
end
