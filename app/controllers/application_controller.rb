class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  get '/games' do
    games = Game.all.order(:title).limit(10)
    games.to_json
  end

  get '/games/:id' do
    game = Game.find(params[:id])

    game.to_json(only: [:id, :title, :genre, :price], include: {
      reviews: { only: [:comment, :score], include: {
        user: { only: [:name] }
      } }
    })
  end

  post '/games' do 
    game = Game.create(title: params[:title],genre: params[:genre], price: params[:price], platform: params[:platform])
    game.to_json
  end

  get '/reviews' do 
    reviews = Review.all.limit(10)
    reviews.to_json
  end

  get '/reviews/:id' do 
    review = Review.find(params[:id])
    review.to_json
  end

  patch '/reviews/:id' do 
    review = Review.find(params[:id])
    review.update(score: params[:score], comment: params[:comment])
    review.to_json
  end
end
