class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all.reverse_order
  end
 
  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @user = current_user
  end

  def new
    @post = Post.new
  end

  def edit
  end
  
  def create
    @post = Post.new(post_params)
    @post.user = current_user
      respond_to do |format|
        if @post.save
          format.html { redirect_to user_path(current_user), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to user_path(current_user), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to user_path(current_user), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :title, :content, :photo)
    end
end
