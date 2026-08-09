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
    "玄関を掃除する",
    "ベランダを掃除する",
    "テレビ台を拭く",
    "棚のほこりを取る",
    "クイックルワイパーをかける",
    "ゴミ箱を洗う",
    "電子レンジを掃除する",
    "シンクを磨く",
    "蛇口を磨く",
    "換気扇を拭く",
    "ダイニングテーブルを拭く",
    "イスを拭く",
    "ドアノブを消毒する",
    "スイッチを拭く",
    "玄関マットを掃除する",
    "靴を並べる",
    "観葉植物の手入れをする",
    "クッションを整える",
    "カーペットを掃除する",
    "排水口を掃除する",
    "ゴミ受けを洗う"
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
    "料理後のキッチンを片付ける",
    "ご飯を炊く",
    "味噌汁を作る",
    "サラダを作る",
    "野菜を切る",
    "肉や魚を解凍する",
    "食材を冷凍保存する",
    "調味料を補充する",
    "麦茶を作る",
    "コーヒーを淹れる",
    "水筒を準備する",
    "テーブルを準備する",
    "食卓を片付ける",
    "生ゴミを処理する",
    "賞味期限を確認する",
    "冷蔵庫の中身を確認する"
  ],

  laundry => [
    "洗濯する",
    "洗濯物を干す",
    "洗濯物を取り込む",
    "洗濯物をたたむ",
    "服をしまう",
    "アイロンをかける",
    "布団を干す",
    "シーツを交換する",
    "タオルを交換する",
    "洗濯ネットを使う",
    "色物を分けて洗う",
    "靴を洗う",
    "上履きを洗う",
    "ハンガーを片付ける",
    "洗剤を補充する"
  ],

  shopping => [
  "食材を買う",
  "日用品を買う",
  "買い物リストを作る",
  "ネット注文する",
  "在庫を確認する",
  "スーパーへ買い物に行く",
  "ドラッグストアへ行く",
  "100円ショップへ行く",
  "特売をチェックする",
  "冷蔵庫の在庫を確認する",
  "冷凍庫の在庫を確認する",
  "野菜を買う",
  "肉を買う",
  "魚を買う",
  "牛乳を買う",
  "パンを買う",
  "お米を買う",
  "調味料を買う",
  "トイレットペーパーを買う",
  "ティッシュを買う",
  "洗剤を買う",
  "シャンプーを買う",
  "歯磨き粉を買う",
  "ゴミ袋を買う",
  "ペット用品を買う"
],

  organizing => [
  "ゴミをまとめる",
  "ゴミを出す",
  "段ボールを片付ける",
  "部屋を片付ける",
  "収納を整理する",
  "クローゼットを整理する",
  "本棚を整理する",
  "書類を整理する",
  "郵便物を整理する",
  "不要な物を捨てる",
  "リサイクルに出す",
  "季節物を収納する",
  "衣替えをする",
  "引き出しを整理する",
  "キッチン収納を整理する",
  "食品庫を整理する",
  "洗面所を整理する",
  "玄関収納を整理する",
  "子どものおもちゃを片付ける",
  "靴箱を整理する",
  "バッグを片付ける",
  "充電コードを整理する",
  "説明書を整理する",
  "薬箱を整理する",
  "防災用品を確認する"
],

family_support => [
  "子どもの準備をする",
  "子どもの送り迎えをする",
  "宿題を見る",
  "子どもの話を聞く",
  "家族の予定を確認する",
  "家族の予定を共有する",
  "学校のお便りを確認する",
  "連絡帳を確認する",
  "翌日の持ち物を確認する",
  "保育園の準備をする",
  "学校の準備をする",
  "習い事へ送る",
  "習い事へ迎えに行く",
  "病院へ連れて行く",
  "薬を飲ませる",
  "体温を測る",
  "子どもをお風呂に入れる",
  "歯磨きを手伝う",
  "絵本を読む",
  "寝かしつけをする",
  "遊び相手をする",
  "学校行事を確認する",
  "PTAのお知らせを確認する",
  "写真を整理する",
  "家族写真を撮る"
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

# ご褒美カード
reward_cards = [
  { name: "SSRご褒美カード", rarity: "SSR", image: "ssr_01.png" },

  { name: "SRご褒美カード1", rarity: "SR", image: "sr_01.png" },
  { name: "SRご褒美カード2", rarity: "SR", image: "sr_02.png" },
  { name: "SRご褒美カード3", rarity: "SR", image: "sr_03.png" },

  { name: "レアご褒美カード1", rarity: "R", image: "rare_01.png" },
  { name: "レアご褒美カード2", rarity: "R", image: "rare_02.png" },
  { name: "レアご褒美カード3", rarity: "R", image: "rare_03.png" },
  { name: "レアご褒美カード4", rarity: "R", image: "rare_04.png" },
  { name: "レアご褒美カード5", rarity: "R", image: "rare_05.png" },
  { name: "レアご褒美カード6", rarity: "R", image: "rare_06.png" },

  { name: "ノーマルご褒美カード1", rarity: "N", image: "normal_01.png" },
  { name: "ノーマルご褒美カード2", rarity: "N", image: "normal_02.png" },
  { name: "ノーマルご褒美カード3", rarity: "N", image: "normal_03.png" },
  { name: "ノーマルご褒美カード4", rarity: "N", image: "normal_04.png" },
  { name: "ノーマルご褒美カード5", rarity: "N", image: "normal_05.png" },
  { name: "ノーマルご褒美カード6", rarity: "N", image: "normal_06.png" },
  { name: "ノーマルご褒美カード7", rarity: "N", image: "normal_07.png" },
  { name: "ノーマルご褒美カード8", rarity: "N", image: "normal_08.png" },
  { name: "ノーマルご褒美カード9", rarity: "N", image: "normal_09.png" },
  { name: "ノーマルご褒美カード10", rarity: "N", image: "normal_10.png" }
]

reward_cards.each do |card|
  RewardCard.find_or_create_by!(image: card[:image]) do |reward_card|
    reward_card.name = card[:name]
    reward_card.rarity = card[:rarity]
  end
end
