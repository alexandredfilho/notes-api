class ApplicationController < ActionController::API
  before_action :set_locale

  rescue_from ActiveRecord::RecordNotFound do
    render json: { errors: [ I18n.t('errors.messages.not_found') ] }, status: :not_found
  end

  private

  def set_locale
    requested = request.headers['Accept-Language'].to_s
    I18n.locale = requested.presence_in(%w[pt-BR en]) || I18n.default_locale
  end
end
