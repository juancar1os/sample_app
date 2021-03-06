class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  
  #Crear el indice de usuarios
  def index
    @title = "Todos los usuarios"
    #Crea paginación de los usuarios para mostrarlos en cachitos con will_paginate
    @users = User.paginate(:page => params[:page])
  end
  
  #Mostrar lista de usuarios
  def show
    @user = User.find(params[:id])
    @title = @user.nombre
    @microposts = @user.microposts.paginate(:page => params[:page])
  end
  
  def new
    @title = "Registro"
    if current_user
      redirect_to root_path
    end
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
  
  def edit
    #@user = User.find(params[:id])
    @title = "Editar usuario"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Perfil actualizado"
      redirect_to @user
    else
      @title = "Editar usuario"
      render 'edit'
    end
  end
  
  def destroy
    usuario = User.find(params[:id])
    if usuario == current_user 
      flash[:success] = "meh"
    else
      usuario.destroy
      flash[:success] = "Usuario borrado"
    end
    redirect_to users_path
  end
  
  def following
    @title = "Siguiendo a"
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Seguidores"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end
  
  private 
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
