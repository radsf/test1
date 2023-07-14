require 'dxruby'

# スタート画面のクラス定義
class StartScene
  def initialize
    @font = Font.new(48)
  end

  def update
    # スペースキーが押されたらゲームを開始
    if Input.key_push?(K_RETURN)
      SceneManager.next_scene(:game)
    end
  end

  def draw
    Window.draw_font(200, 200, 'START', @font)
  end
end

# ゲーム画面のクラス定義
class GameScene
  def initialize
    # プレイヤーの初期化など、ゲームの初期化処理を行う
    @player = Player.new
    @score = 0

    # 弾と敵の配列
    @player_bullets = []
    @enemy_bullets = []
    @enemies = []
  end

  def update
    # プレイヤーや弾、敵の更新処理を行う
    @player.update
    @player_bullets.each(&:update)
    @enemy_bullets.each(&:update)
    @enemies.each(&:update)

    # プレイヤーの弾と敵の弾の衝突判定と削除処理
    @player_bullets.dup.each do |player_bullet|
      @enemy_bullets.dup.each do |enemy_bullet|
        if player_bullet === enemy_bullet
          player_bullet.vanish
          enemy_bullet.vanish
          @player_bullets.delete(player_bullet)
          @enemy_bullets.delete(enemy_bullet)
          increase_score(10)
          break
        end
      end
    end

    # スペースキーが押されたらプレイヤーの弾を発射
    if Input.key_push?(K_SPACE)
      player_bullet = Bullet.new(@player.x + 28, @player.y)
      @player_bullets.push(player_bullet)
    end

    # ランダムに敵を生成
    if rand(100) < 3
      enemy = Enemy.new(rand(640), 0)
      @enemies.push(enemy)
    end

    # 敵の弾とプレイヤーの衝突判定と削除処理
    @enemy_bullets.dup.each do |enemy_bullet|
      if enemy_bullet === @player
        enemy_bullet.vanish
        @enemy_bullets.delete(enemy_bullet)
        break
      end
    end

    # プレイヤーの弾と敵の衝突判定と削除処理
    @player_bullets.dup.each do |player_bullet|
      @enemies.dup.each do |enemy|
        if player_bullet === enemy
          player_bullet.vanish
          enemy.vanish
          @player_bullets.delete(player_bullet)
          @enemies.delete(enemy)
          increase_score(10)
          break
        end
      end
    end

    # 敵の弾をランダムに生成
    if rand(100) < 2
      enemy_bullet = EnemyBullet.new(rand(640), 0)
      @enemy_bullets.push(enemy_bullet)
    end
  end

  def draw
    # 背景の描画
    Window.draw(0, 0, @background)

    # プレイヤーや弾、敵の描画処理を行う
    @player.draw
    @player_bullets.each(&:draw)
    @enemy_bullets.each(&:draw)
    @enemies.each(&:draw)

    # 得点の表示
    score_text = "Score: #{@score}"
    Window.draw_font(10, 10, score_text, @font)

    # 画面のクリア
    Window.bgcolor = C_BLACK
  end

  private

  def increase_score(points)
    @score += points
  end
end

# プレイヤーのクラス定義
class Player < Sprite
  def initialize
    image = Image.new(64, 64).circle_fill(32, 32, 32, C_RED)
    super(320, 400, image)
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

# 敵の弾のクラス定義
class EnemyBullet < Sprite
  def initialize(x, y)
    image = Image.new(16, 16).circle_fill(8, 8, 8, C_CYAN)
    super(x, y, image)
    @dx = rand(-2..2)
    @dy = rand(1..3)
  end

  def update
    self.x += @dx
    self.y += @dy
    vanish if self.y > 480
  end
end


# シーンマネージャーのクラス定義
class SceneManager
  @@scenes = {}

  def self.add_scene(name, scene)
    @@scenes[name] = scene
  end

  def self.next_scene(name)
    @@current_scene = @@scenes[name]
  end

  def self.run
    @@current_scene = @@scenes.values.first

    Window.loop do
      @@current_scene.update
      @@current_scene.draw
    end
  end
end

# スタート画面を追加
start_scene = StartScene.new
SceneManager.add_scene(:start, start_scene)

# ゲーム画面を追加
game_scene = GameScene.new
SceneManager.add_scene(:game, game_scene)

# 最初の画面をスタート画面に設定
SceneManager.next_scene(:start)

# 背景画像を読み込む
background_image = Image.load('background.jpeg')

# ゲーム画面に背景を設定
game_scene.instance_variable_set(:@background, background_image)

# フォントを読み込む
font = Font.new(35)

# ゲーム画面にフォントを設定
game_scene.instance_variable_set(:@font, font)

SceneManager.run
