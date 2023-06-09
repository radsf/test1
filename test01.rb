require 'dxruby'

Window.width = 640
Window.height = 480

Window.bgcolor = [255, 128, 255, 255] # 追加
ground_img = Image.new(640, 80, [255, 116, 80, 48]) # 追加
ground_img.box_fill(0, 0, 640, 10, [255, 0, 128, 0]) # 追加

Window.draw(0, 400, ground_img) # 追加

player_image = Image.new(32, 32)  # プレイヤーの画像を作成

player = Sprite.new(0, 0, player_image)  # プレイヤースプライトを作成

player_image = Image.new(32, 32)  # プレイヤーの画像を作成

player = Sprite.new(0, 0, player_image)  # プレイヤースプライトを作成

bullet_image = Image.new(8, 8)  # 弾の画像を作成

bullets = []  # 弾の配列

enemy_image = Image.new(32, 32)  # 敵の画像を作成

enemies = []  # 敵の配列

Window.loop do
  # プレイヤーの移動や弾の発射処理を記述する

  Sprite.update(bullets)  # 弾の位置を更新する

  # 弾と敵の当たり判定
  Sprite.check(bullets, enemies)

  Sprite.update(enemies)  # 敵の位置を更新する

  Sprite.draw(enemies)  # 敵を描画する

end