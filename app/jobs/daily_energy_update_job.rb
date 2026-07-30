class DailyEnergyUpdateJob < ApplicationJob
  queue_as :default

  def perform
    Family.find_each do |family|
      EnergyManager.new(family).daily_update
    end
  end
end
