class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @title = @user.nombre
  end
  
  def new
    @title = "Registro"
  end

end
