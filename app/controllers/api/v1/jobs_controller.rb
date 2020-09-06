class Api::V1::JobsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_job, only: [ :show, :update, :new_time_entry ]

  def index
    @jobs = policy_scope(Job)
  end

  def show
  end

  def update
   if @job.update(job_params)
    render :show
  else
    render_error
    end
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    authorize @job
    if @job.save
      render :show
    else
      render_error
    end
  end

  def new_time_entry
    last_shift = @job.shifts.last

    if (last_shift && last_shift.clock_out) || !last_shift
      shift = Shift.new({
        job_id: @job.id,
        clock_in: Time.now,
        user_id: current_user.id
      })
    elsif !last_shift.clock_out
      shift = last_shift
      shift.clock_out = Time.now
    end

    shift.save
  end

 private

  def set_job
    @job = Job.find(params[:id])
    authorize @job
  end

  def job_params
    params.require(:job).permit(:position)
  end

  def render_error
    render json: { errors: @restaurant.errors.full_messages },
      status: :unprocessable_entity
  end
end