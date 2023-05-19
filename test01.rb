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
