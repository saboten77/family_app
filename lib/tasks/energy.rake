namespace :energy do
  desc "毎日0時に家族エネルギーを更新"

  task daily_update: :environment do
    Family.find_each do |family|
      EnergyManager.new(family).daily_update
    end

    puts "🌱 家族エネルギーを更新しました！"
  end
end
