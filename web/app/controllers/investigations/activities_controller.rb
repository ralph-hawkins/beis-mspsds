class Investigations::ActivitiesController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  before_action :set_investigation, only: %i[create new comment]
  before_action :create_activity, only: %i[create]

  def new
    return unless params[:commit] == "Continue"

    case params[:activity_type]
    when "comment"
      redirect_to comment_investigation_activities_path(@investigation)
    when "correspondence"
      redirect_to new_investigation_correspondence_path(@investigation)
    when "product"
      redirect_to new_investigation_product_path(@investigation)
    when "testing_request"
      redirect_to new_request_investigation_tests_path(@investigation)
    when "testing_result"
      redirect_to new_result_investigation_tests_path(@investigation)
    when "corrective_action"
      redirect_to new_investigation_corrective_action_path(@investigation)
    when "business"
      redirect_to new_investigation_business_path(@investigation)
    else
      @activity_type_empty = true
    end
  end

  def comment; end

  # POST /activities
  # POST /activities.json
  def create
    respond_to do |format|
      if @activity.save
        format.html do
          redirect_to investigation_url(@investigation), notice: "Comment was successfully added."
        end
        format.json { render :show, status: :created, location: @activity }
      else
        format.html do
          redirect_to investigation_url(@investigation), notice: "Comment was not successfully added."
        end
        format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
    end
  end

private

  def create_activity
    @activity = CommentActivity.new(activity_params)
    @investigation.activities << @activity
    @activity.source = UserSource.new(user: current_user)
  end

  def set_investigation
    @investigation = Investigation.find(params[:investigation_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def activity_params
    params.require(:comment_activity).permit(:body)
  end
end
