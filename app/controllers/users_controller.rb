class RegistrationsController < ApplicationController
	before_action :authenticate_user!

    def after_update_path_for(resource)
      user_path(resource)
    end
end