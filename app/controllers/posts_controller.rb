class PostsController < ApplicationController
  load_and_authorize_resource
  # GET /posts
  # GET /posts.json
  def index
    @user = User.find(params[:user_id])
    @user_posts = Post.includes(:author, :likes, :comments).where(author_id: params[:user_id]).order(created_at: :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
    @params = params
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = 'New post created successfully'
      redirect_to user_post_path(id: @post.id, user_id: @post.author_id)
    else
      render :new, status: :unprocessable_entity, content_type: 'text/html'
      headers['Content-Type'] = 'text/html'
      flash[:danger] = 'Post could not be created'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    authorize! :destroy, @post
    @comment = @post.comments
    @comment.each(&:destroy)
    @post.destroy
    flash[:success] = ['Post Deleted Successfully']

    respond_to do |format|
      format.html { redirect_to "/users/#{current_user.id}/posts" }
      format.json { head :no_content }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end
end
