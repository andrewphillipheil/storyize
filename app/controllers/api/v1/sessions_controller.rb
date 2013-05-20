class Api::V1::SessionsController < ApplicationController

	def create
		@user = User.where(email: params[:email], password: params[:password]).first
		if @user
			render json: {
		      meta: {
		        status: 200,
		        msg: "OK",
		        params: params
		      },
		      response: { user_id: @user.id }
		    }
		else
			render json: {
		      meta: {
		        status: 500,
		        msg: "failure",
		        params: params
		      },
		      errors: "Invalid username or password"
		    }
		end
	end

end