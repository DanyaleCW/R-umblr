
class Post < ActiveRecord::Base
    belongs_to :users
    validates :post, length: { maximum: 5 }
end