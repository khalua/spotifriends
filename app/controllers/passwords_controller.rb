class PasswordsController < Devise::PasswordsController
  
  protected
    def after_sending_reset_password_instructions_path_for(resource_name)
        if session[:token_url]
          session[:token_url]
        else
          super
        end
    end
end