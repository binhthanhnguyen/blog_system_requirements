class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user , only: [:destroy]
  def create
    @entry = Entry.find params[:entry_id]
    @comment = current_user.comments.build(comment_params)
    @comment.entry = @entry
    # if @comment.save
    #   flash[:success] = "Comment created!"
    #   redirect_to request.referrer
    # else
    #   render 'static_pages/home'
    # end
    @comment.save
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end

  def destroy
    @entry = @comment.entry
    @comment.destroy
    flash[:success] = "Comment deleted"
    # redirect_to request.referrer || root_url
    respond_to do |format|
      format.html { redirect_to request.referrer }
      format.js
    end
  end


  private
    def comment_params
        params.require(:comment).permit :content, :entry_id
    end

    def correct_user
      @comment = current_user.comments.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end
end
