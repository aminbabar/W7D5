class ApplicationController < ActionController::Base
    # C E L L L help    
    helper_method :current_user, :logged_in?, :moderator?

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def ensure_logged_in
        redirect_to new_session_url unless logged_in?
    end

    def ensure_logged_out
        redirect_to users_url if logged_in?
    end

    def logged_in?
        !!current_user
    end

    def login(user)
        session[:session_token] = user.reset_session_token
    end

    def logout!
        current_user.reset_session_token if logged_in?
        session[:session_token] = nil
        @current_user = nil
    end

    def moderator?
        @sub.user_id == current_user.id
    end

    def ensure_moderator
        # debugger
        @sub = Sub.find(params[:id])
        redirect_to subs_url unless moderator?
    end
end
