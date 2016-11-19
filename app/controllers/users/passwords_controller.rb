class Users::PasswordsController < Devise::PasswordsController
  def new
    super
  end

  def create
    # super
    self.resource = resource_class.send_reset_password_instructions(resource_params)

    if successfully_sent?(resource)
      redirect_to root_path, :notice => "Instruction has been send to your email"
    else
      respond_with(resource)
    end
  end

  def edit
    super
  end

  def update
    super
  end
end
