class PostsController < ApplicationController
    # GET /posts/new
  def new
    @post = Post.new
  end
  # POST /posts
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH /posts/:id
  # PUT   /posts/:id
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  # GET /posts/:id/edit
  def edit
    @post = Post.find(params[:id])
  end

  # DELETE /posts/:id
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path
  end

  def like
  begin
    @post = Post.find(params[:id])
    @post.likes += 1
    respond_to do |format|
      if @post.save
        format.html { redirect_to action: params[:is_show].to_i == 0 ? 'index' : 'show' }
      else
        format.html { render :new }
      end
    end
    rescue e
      logger.error e
      format.html { render :new }
    end
  end


  private
    def post_params
      params.require(:post).permit(:title, :text)
    end
end
