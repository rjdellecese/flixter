class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :require_enrolled_in_course
	
	def show
	end

	private

	def require_enrolled_in_course
		current_course = current_lesson.section.course
		unless current_user.enrolled_in?(current_course)
			flash[:alert] = "You must be enrolled in this course to view the lessons"
			redirect_to course_path(current_course)
		end
	end

	helper_method :current_lesson
	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

end
