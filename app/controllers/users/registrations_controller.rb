class Users::RegistrationsController < Devise::RegistrationsController
  layout "admin", only: [:edit]
  def create
    build_resource(sign_up_params)

    if resource.save

    else
      @error = resource.errors.full_messages.to_sentence
    end
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

end
