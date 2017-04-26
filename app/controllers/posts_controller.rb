class PostsController < ApplicationController
  before_filter :logged_in?, exept: [:index]

  def new
    unless current_user
      flash[:danger] = 'You need to login/signup to make posts!'
      redirect_to root_path
    end
  end

  def create
    if current_user
      @post = Post.new(post_params)
      @post.user_id = current_user.id
      if @post.save
        flash[:success] = 'Post has been created.'
        redirect_to posts_index_path
      else
        render :new
      end
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
