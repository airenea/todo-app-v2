class Category < ApplicationRecord
    has_many :tasks, dependent: :destroy
    validates :title, presence: true, length: { maximum: 15 }
    validates :body, presence: true, length: { minimum: 5 }
    validates :emoji, presence: true
end
