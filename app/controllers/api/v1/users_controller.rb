class Api::V1::UsersController < ApplicationController

	def create
		@user = User.new(params[:user])
		if @user.save
			render json: 
		else

		end
	end

end