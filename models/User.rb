
class User < ActiveRecord::Base
    has_many :posts
    validates :post, length: { maximum: 5 }
end