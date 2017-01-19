class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    # @comment = Comment.new(comment: params[:comment][:comment], survey_question_id: params[:comment][:survey_question_id], user_id: params[:comment][:user_id])
    @survey_question = SurveyQuestion.where(id: comment_params[:survey_question_id]).first
    @comment = Comment.build_from(@survey_question, current_user.id, comment_params[:body])
    if @comment.save
    else

    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      # redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /comments/1
  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  def reply
    @parent_comment = Comment.where(id: params[:id]).first
    @survey_question = SurveyQuestion.where(id: comment_params[:survey_question_id]).first
    @comment = Comment.build_from(@survey_question, current_user.id, comment_params[:body])
    if @comment.save
      @comment.move_to_child_of(@parent_comment)
    else

    end
  end

  def like
    @comment = Comment.find(params[:id])
    if current_user
      @comment.liked_by current_user
      render json: {:status => "success", :count => @comment.votes_for.size}
    else
      render json: {:status => "failed", :message => "Sign in first."}
    end
  end

  def dislike
    @comment = Comment.find(params[:id])
    if current_user
      @comment.unliked_by current_user
      render json: {:status => "success", :count => @comment.votes_for.size}
    else
      render json: {:status => "failed", :message => "Sign in first."}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def comment_params
      params.require(:comment).permit(:body, :survey_question_id)
    end
end
