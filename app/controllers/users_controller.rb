class UsersController < ApplicationController
  def create
    @user = User.create(user_params)

    if @user.valid?
      positive_response
    else
      negative_response
    end

  end

  def login
    @user = User.find_by(username: user_params[:username])

    if @user && @user.authenticate(user_params[:password])
      positive_response
    else
      negative_response
    end
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def positive_response
    token = encode_token({user_id: @user.id})
    render json: {user: @user, token: token}, status: :ok
  end

  def negative_response
    render json: {error: 'Usuário ou senha inválidos.'}, status: :unprocessable_entity
  end
end
