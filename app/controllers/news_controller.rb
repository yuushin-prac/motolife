class NewsController < ApplicationController
  require 'news-api'
  require 'will_paginate/array'
  
  def index
    news = News.new(ENV['NEWS_API_KEY'])
    @news = news.get_everything(q: '%E3%83%90%E3%82%A4%E3%82%AF', sortBy: "popularity").paginate(
                                                                    page: params[:page], per_page: 18)
  end

end