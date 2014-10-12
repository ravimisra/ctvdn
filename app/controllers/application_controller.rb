class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  
  before_filter :authorize
  
  
  protected
    def authorize
      allowed = false
      
      user = User.find_by_id(session[:user_id])
      if user.nil?
        redirect_to :login, flash: {alert: "you must login to access this page"}
        return
      end
  
      puts "controller:#{params[:controller]}|action:#{params[:action].to_sym}|id:#{params[:id]} || user_id:#{user.id}"
      
      c = User.role_type_to_i(params[:controller])
      puts "role_type_to_i:#{c}"
      
      case params[:action].to_sym
      when :show
        allowed = true if params[:id].to_i == user.id
      when :index
        allowed = user.has_role?(c + User::CAN_LIST) 
      when :new, :create
        allowed = user.has_role?(c + User::CAN_ADD)
      when :destroy
        allowed = user.has_role?(c + User::CAN_DESTROY) || params[:id].to_i == user.id
      when :edit, :update
        allowed = user.has_role?(c + User::CAN_EDIT) || params[:id].to_i == user.id
      else
        allowed = true
      end
      
      allowed = true if user.has_role?(User::IS_AN_ADMIN)
      unless allowed
        redirect_to action: :show, id: user.id, flash: {alert: "you are not allowed to access this page"}
        return
      end
    end
end
