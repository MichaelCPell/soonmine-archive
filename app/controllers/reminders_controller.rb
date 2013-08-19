class RemindersController < ApplicationController
  def new
    @reminder = Reminder.new
  end

  def create
    processed_date = Date.new(params[:reminder]["date(1i)"].to_i,params[:reminder]["date(2i)"].to_i, params[:reminder]["date(3i)"].to_i)

    processed_params = 
      ActionController::Parameters.new({reminder: {date: processed_date,
                                        email: params[:reminder][:email],
                                        name: params[:reminder][:name],
                                        user_id: current_user.id}})

    @reminder = Reminder.new(reminder_params(processed_params))


    flash[:notice] = "We have successfully created your reminder!"
    redirect_to current_user
  end

  def show
  end

  def index
  end

  private

  def reminder_params(processed_params)
    processed_params.require(:reminder).permit(:name, :recipient_email, :date, :user_id)
  end
end