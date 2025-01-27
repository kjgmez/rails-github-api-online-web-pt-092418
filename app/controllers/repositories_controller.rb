class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    user = JSON.parse(resp.body)
    session[:user] = user['login']

    respo = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
    end

    @repo = JSON.parse(respo.body)

  end

  def create
    respo = Faraday.post 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['accept'] = 'application/json'
      req.params['name'] = params[:name]
    end
    redirect_to '/'
  end

end
