# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 家事カテゴリ作成
cleaning = TaskCategory.find_or_create_by!(name: "掃除")
cooking = TaskCategory.find_or_create_by!(name: "料理")
laundry = TaskCategory.find_or_create_by!(name: "洗濯")
shopping = TaskCategory.find_or_create_by!(name: "買い物")
organizing = TaskCategory.find_or_create_by!(name: "ゴミ・片付け")
family_support = TaskCategory.find_or_create_by!(name: "子ども・家族サポート")
kindness = TaskCategory.find_or_create_by!(name: "思いやり・気遣い")


# 家事項目
tasks = {
  cleaning => [
    "掃除機をかける",
    "床を拭く",
    "トイレ掃除",
    "お風呂掃除",
    "洗面台を掃除する",
    "キッチンを掃除する",
    "コンロを磨く",
    "冷蔵庫を整理する",
    "窓を拭く",
    "玄関を掃除する"
  ],

  cooking => [
    "朝ごはんを作る",
    "昼ごはんを作る",
    "晩ご飯を作る",
    "献立を考える",
    "食材を下ごしらえする",
    "お弁当を作る",
    "食器を洗う",
    "食器を片付ける",
    "作り置きをする",
    "料理後のキッチンを片付ける"
  ],

  laundry => [
    "洗濯する",
    "洗濯物を干す",
    "洗濯物を取り込む",
    "洗濯物をたたむ",
    "服をしまう",
    "アイロンをかける",
    "布団を干す",
    "シーツを交換する"
  ],

  shopping => [
    "食材を買う",
    "日用品を買う",
    "買い物リストを作る",
    "ネット注文する",
    "在庫を確認する"
  ],

  organizing => [
    "ゴミをまとめる",
    "ゴミを出す",
    "段ボールを片付ける",
    "部屋を片付ける",
    "収納を整理する"
  ],

  family_support => [
    "子どもの準備をする",
    "子どもの送り迎えをする",
    "宿題を見る",
    "子どもの話を聞く",
    "家族の予定を確認する",
    "家族の予定を共有する"
  ],

  kindness => [
    "家族にありがとうを伝える",
    "飲み物を用意する",
    "疲れている家族を休ませる",
    "相手の好きなものを用意する",
    "家族に声をかける",
    "記念日を覚えておく"
  ]
}


tasks.each do |category, task_names|
  task_names.each do |task_name|
    Task.find_or_create_by!(
      name: task_name,
      task_category: category
    )
  end
end
