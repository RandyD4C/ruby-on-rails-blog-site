module Api
  module V1
    class ArticlesController < ApplicationController
      # GET /api/v1/articles
      # Returns a list of all articles, inluding their associated user's id, name, and email.
      def index
        articles = Article.all.includes(:user)
        render json: articles.as_json(
          include: { 
            user: { 
              only: [:id, :name, :email]
             }
           }
        )
      end
    end
  end
end
