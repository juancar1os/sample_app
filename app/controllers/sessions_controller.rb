class SessionsController < ApplicationController
  def new
    @title = "Iniciar sesion"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                              params[:session][:password])
    if user.nil?
      #mensaje de error y volver a crear la página de sesion
      flash.now[:error] = "Error de email/password"
      @title = "Iniciar sesion"
      render 'new'
    else
      #Iniciar sesión con el usuario
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
