require 'sinatra/base'
require 'sinatra/reloader'
require 'octokit'

class RepoSearchApp < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  post '/search' do
    @query = params[:query]
    @results = client.search_repositories(@query)[:items]
    erb :index
  end

  private

  def client
    @client ||= Octokit::Client.new(:access_token => ENV['GITHUB_ACCESS_TOKEN'])
  end
end
