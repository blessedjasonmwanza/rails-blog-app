class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    if @like.save!
      redirect_to user_post_path(id: @like.post_id, user_id: @like.author_id)
      flash[:success] = 'Comment was created'
    else
      flash[:danger] = 'Post could not be liked'
    end
  end

  private

  def like_params
    params.require(:like).permit(:author_id, :post_id)
  end
end
