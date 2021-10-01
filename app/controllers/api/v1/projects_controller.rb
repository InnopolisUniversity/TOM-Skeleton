class Api::V1::ProjectsController < ApplicationController
  def index
    projects = TomProject.all
    render json: projects, status: 200
  end

  def create

    json = JSON.parse(
      case request.content_type
      when 'application/x-www-form-urlencoded'
        params[:payload]
      when 'application/json'
        request.body.read
      else
        raise "Invalid content-type: \"#{request.content_type}\""
      end
    )

    project = TomProject.new(
      name: json['name'],
      description: json['description'],
      isactive: 'Y'
    )

    if project.save
      render json: project, status: 201
    else
      render json: {error: "Error creation entity"}, status: 400
    end
  end

  def show
    project = TomProject.find_by(id: params[:id])

    if project
      render json: project, status: 200
    else
      render json: {error: "Project not found"}
    end
  end

  private
  def project_params
    params.require(:project).permit([
      :name,
      :description
                                    ])
  end
end
