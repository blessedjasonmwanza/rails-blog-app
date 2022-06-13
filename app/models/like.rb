class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  def increase_post_like_counter
    post.increment!(:likes_counter)
  end
end
