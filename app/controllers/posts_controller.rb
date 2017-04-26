class PostsController < ApplicationController
  before_filter :logged_in?, exept: [:index]

  def new
    @user = User.find_by(id: current_user.id)
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = 'Post has been created.'
      redirect_to posts_index_path
    else

      render :new
    end
  end

  def index
    @posts = Post.all
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end

end
