require 'dxruby'

Window.width = 640
Window.height = 480

Window.loop do
  # ゲームの処理を記述する
end

player_image = Image.new(32, 32)  # プレイヤーの画像を作成

player = Sprite.new(0, 0, player_image)  # プレイヤースプライトを作成

Window.loop do
  player.draw  # プレイヤーを描画する
end

player_image = Image.new(32, 32)  # プレイヤーの画像を作成

player = Sprite.new(0, 0, player_image)  # プレイヤースプライトを作成

Window.loop do
  player.draw  # プレイヤーを描画する
end

bullet_image = Image.new(8, 8)  # 弾の画像を作成

bullets = []  # 弾の配列

Window.loop do
  # プレイヤーの移動や弾の発射処理を記述する

  Sprite.update(bullets)  # 弾の位置を更新する

  # 弾と敵の当たり判定
  Sprite.check(bullets, enemies)
end

enemy_image = Image.new(32, 32)  # 敵の画像を作成

enemies = []  # 敵の配列

Window.loop do
  # 敵の生成や移動処理を記述する

  Sprite.update(enemies)  # 敵の位置を更新する

  # 弾と敵の当たり判定
  Sprite.check(bullets, enemies)

  Sprite.draw(enemies)  # 敵を描画する
end
