class UsersController < ApplicationController

  def show
    if session[:user_id].nil? == false
      @user = User.find(session[:user_id])
      @movies = []
      @user.parties.each do |party|
        conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
          faraday.params[:api_key] = ENV['movies_api_key']
        end
         movie_id_response = conn.get("/3/movie/#{party.party_movie_id}")
         @movie = JSON.parse(movie_id_response.body, symbolize_names: true)
         @movies.push(@movie)
      end
     else
       flash[:alert] = "Must be logged in or Registered"
       redirect_to root_path
    end
  end

  def new

  end

  def create
    @user = user_params
    @user[:name] = @user[:name].downcase
    @new_user = User.new(@user)
    if @new_user.save
      session[:user_id] = @new_user.id
      flash[:success] = "Welcome, #{@new_user.name}!"
      redirect_to dashboard_path
    elsif @user[:name].present? == false
      flash[:alert] = "Error name missing!"
      render :new
    elsif @user[:email].present? == false
      flash[:alert] = "Error email missing!"
      render :new
    elsif @user[:password].present? == false
      flash[:alert] = "Error password missing!"
      render :new
    elsif @user[:password_confirmation].present? == false
      flash[:alert] = "Error password confirmation missing!"
      render :new
    end
  end

  def login
    @user_found = User.find_by(email: params[:email])
    if @user_found && @user_found.authenticate(params[:password])
      session[:user_id] = @user_found.id
      flash[:success] = "Welcome, #{@user_found.name.capitalize}!"
      redirect_to dashboard_path
    else
      flash[:alert] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
