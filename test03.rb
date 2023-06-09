require 'dxruby'

# プレイヤーのクラス定義
class Player < Sprite
  def initialize
    image = Image.new(64, 64).circle_fill(32, 32, 32, C_RED)
    @image = Image.load('sensya.png')  # 洗車の画像
    super(320, 400, @image)
  end

  def update
    self.x += Input.x * 4
    self.y += Input.y * 4
  end
end

# 弾のクラス定義
class Bullet < Sprite
  def initialize(x, y)
    image = Image.new(8, 8).circle_fill(4, 4, 4, C_YELLOW)
    super(x, y, image)
  end

  def update
    self.y -= 8
    vanish if self.y < 0
  end
end

# 敵のクラス定義
class Enemy < Sprite
  def initialize(x, y)
    image = Image.new(48, 48).circle_fill(24, 24, 24, C_GREEN)
    super(x, y, image)
  end

  def update
    self.y += 2
    vanish if self.y > 480
  end
end

# プレイヤーの初期化
player = Player.new

# 弾と敵の配列
bullets = []
enemies = []

Window.loop do
  # プレイヤーの更新と描画
  player.update
  player.draw

  # 弾の発射処理
  if Input.key_push?(K_SPACE)
    bullet = Bullet.new(player.x + 28, player.y)
    bullets.push(bullet)
  end

  # 弾の更新と描画
  bullets.each do |bullet|
    bullet.update
    bullet.draw
  end

  # 敵の生成処理
  if rand(100) < 3
    enemy = Enemy.new(rand(640), 0)
    enemies.push(enemy)
  end

  # 敵の更新と描画
  enemies.each do |enemy|
    enemy.update
    enemy.draw
  end

  # 弾と敵の衝突判定
  Sprite.check(bullets, enemies)

  # 画面のクリア
  Window.bgcolor = C_BLACK
end
