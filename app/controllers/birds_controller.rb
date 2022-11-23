class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    # find bird
    bird = Bird.find_by(id: params[:id])

    # update bird
    if bird
      bird.update(bird_params)
      render json: bird, status: 202
    else
      render json: { error: "Bird not found"}, status: 404
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    # find the bird first
    bird = Bird.find_by(id: params[:id])

    # update likes
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: "Bird Not Found!"}, status: 404
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
