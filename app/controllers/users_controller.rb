class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.nombre
  end
  
  def new
    @title = "Registro"
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      #Si se pudo salvar, inicia sesión
      sign_in @user
      flash[:success] = "Bienvenido a la app de ejemplo"
      redirect_to @user
    else
      @title = "Registro"
      render 'new'
    end
  end

end
