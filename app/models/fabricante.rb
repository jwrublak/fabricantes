class Fabricante < ApplicationRecord
  has_many :produtos
  validates_uniqueness_of :codigo
end
