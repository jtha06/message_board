class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new(:likes => 0)
  end

  def create  
    @post = Post.new(:content => params[:post][:content], :topic_id => params[:post][:topic_id], :user_id => current_user.id)  
	@post.set_likes(0)
    if @post.save  
      @topic = Topic.find(@post.topic_id)  
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully created post."  
      redirect_to "/topics/#{@post.topic_id}"  
    else  
      render :action => 'new'  
    end  
  end  

  def edit
    @post = Post.find(params[:id])
  end

  def update  
    @post = Post.find(params[:id])  
    if @post.update_attributes(params[:post])  
      @topic = Topic.find(@post.topic_id)  
      @topic.update_attributes(:last_poster_id => current_user.id, :last_post_at => Time.now)  
      flash[:notice] = "Successfully updated post."  
      redirect_to "/topics/#{@post.topic_id}"   
    else  
      render :action => 'edit'  
    end  
  end  

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to "/topics/#{@post.topic_id}" , :notice => "Successfully destroyed post."
  end
  
  def like
    @post = Post.find(params[:id])  
	@post.like
	save!
	redirect_to "/topics/#{@post.topic_id}"
  end
  
  helper_method :like
  
  def dislike
	self.like
	save
  end	
end