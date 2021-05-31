class ArticlesController < ApplicationController

  #byebug

  def show
    #byebug
    @article = Article.find(params[:id])
  end

end
