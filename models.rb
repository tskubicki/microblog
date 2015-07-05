class User < ActiveRecord::Base
	has_and_belongs_to_many :followers, class_name: "User", foreign_key: "followee_id", join_table: "follows", association_foreign_key: "follower_id"
	has_and_belongs_to_many :followees, class_name: "User", foreign_key: "follower_id", join_table: "follows", association_foreign_key: "followee_id"
	
	has_many :posts
	
	has_and_belongs_to_many :groups
end

class Post < ActiveRecord::Base
	belongs_to :user
end

class Group < ActiveRecord::Base
	has_and_belongs_to_many :users
	has_many :posts, through: :users
end