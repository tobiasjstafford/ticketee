class TicketsController < ApplicationController
  before_filter :set_project

  def new
    @ticket = @project.tickets.build
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end
end
