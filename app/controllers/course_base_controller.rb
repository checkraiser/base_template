class CourseBaseController < AccountBaseController
  around_action :scope_current_course

  protected
  def scope_current_course
    if params[:course_id].present?
      @current_course = CourseBase.activate_shard current_account.id, params[:course_id]
      logger.debug "aaaaa #{current_course}"
      yield
    end
  end

  def current_course
    @current_course
  end
  helper_method :current_course
end