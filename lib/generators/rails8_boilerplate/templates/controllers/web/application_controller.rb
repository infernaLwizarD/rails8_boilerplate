class Web::ApplicationController < ApplicationController
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'Доступ запрещён. У вас недостаточно прав для выполнения данного действия.'
    redirect_to(root_path)
  end
end
