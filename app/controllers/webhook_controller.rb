class WebhookController < ApplicationController
  def suso_refresh
    key = params.require(:key)
    if key != ENV["PRIVATE_PASSWORD"]
      render plain: "KO", status: :forbidden and return
    end
    SusoRefreshJob.perform_later
    render plain: "OK"
  end
end
