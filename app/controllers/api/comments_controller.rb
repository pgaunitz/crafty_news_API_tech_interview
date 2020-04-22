class Api::CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create

    comment = Comment.create(comment_params)
    if comment.persisted?
      render json: { message: 'Comment posted' }
    else
      render json: { message: 'Comment cannot be empty' }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id, :article_id)
  end
end
