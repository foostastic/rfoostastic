require_dependency 'suso_refresh'

class SusoRefreshJob < ApplicationJob
  queue_as :default

  def perform(*args)
    refresh = SusoRefresh.new
    refresh.perform
  end

end
