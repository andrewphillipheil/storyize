class Api::V1::UsersController < ApplicationController

	def create
		@user = User.new(params[:user])
		if @user.save
			render json: {
		      meta: {
		        status: 200,
		        msg: "OK",
		        params: params[:user]
		      },
		      response: { user_id: @user.id }
		    }
		else
			render json: {
		      meta: {
		        status: 500,
		        msg: "failure",
		        params: params[:user]
		      },
		      errors: @user.errors.full_messages.join(", ")
		    }
		end
	end

end