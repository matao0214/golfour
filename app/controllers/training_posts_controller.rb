class TrainingPostsController < ApplicationController
  def index
    @training_posts = TrainingPost.all.order(created_at: :desc)
  end

  def show
    @training_post = TrainingPost.find(params[:id])
  end

  def new
    @training_post = TrainingPost.new
  end

  def create
    @training_post = current_user.training_posts.new(training_post_params)
    
    if @training_post.save
      redirect_to root_url, notice: "投稿しました。" 
    else
      render :new
    end
  end

  def edit
    @training_post = TrainingPost.find(params[:id])
  end

  def update
    @training_post = TrainingPost.find(params[:id])
    if @training_post.update(training_post_params)
      redirect_to training_post_url, notice: "投稿を編集しました。"
    else
      render :edit
    end
  end

  def destroy
    training_post = TrainingPost.find(params[:id])
    training_post.destroy
    redirect_to root_url, notice: "投稿を削除しました。"
  end

private

  def training_post_params
    params.require(:training_post).permit(:training_place, :training_advance, :training_task, :training_impression)
  end
end
