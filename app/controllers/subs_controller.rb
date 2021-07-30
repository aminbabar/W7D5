class SubsController < ApplicationController
    before_action :ensure_logged_in, only: [:edit, :update, :create, :new]
    before_action :ensure_moderator, only: [:edit, :update]

    def new
        # @user = current_user
        @sub = Sub.new
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.user_id = current_user.id
        if @sub.save
            render :show
        else
            flash.now[:errors] = @sub.errors.full_messages
            render :new
        end
    end


    def show
        @sub = Sub.find(params[:id])
        render :show
    end


    def index
        @subs = Sub.all
        render :index
    end

    def edit
        # debugger
        @sub = Sub.find(params[:id])
        render :edit
    end

    # title, decription   sub {title: abc, description: sfnawodin wrf}
    def update
        @sub = Sub.find(params[:id])
        if @sub.update(sub_params)
            redirect_to sub_url(@sub)
        else
            render :edit
        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
    end
end