class CommentsController < ApplicationController
    before_action :find_article, only: %i[ create destroy ]

    def create
        @comment = @article.comments.create(comment_params)

        if @comment.save
            redirect_to article_path(@article)
        else
            render "articles/show", status: :unprocessable_entity
        end
    end

    def destroy
        @comment = @article.comments.find(params[:id])
        @comment.destroy
        redirect_to article_path(@article), status: :see_other
    end

    private
        def comment_params
            params.require(:comment).permit(:commenter, :body, :status, :user_id)
        end

        def find_article
            @article = Article.find(params[:article_id])
        end
    end
