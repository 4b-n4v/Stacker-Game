require 'ruby2d'

set title: "Stack Game"


GRID_SIZE = 40
WIDTH = 11
HEIGHT = 20
GRID_COLOR = Color.new('#222222')
BLOCK_COLOR = Color.new(['orange', 'yellow', 'green', 'red'].sample)


set width: WIDTH * GRID_SIZE # 440
set height: HEIGHT * GRID_SIZE # 800

# Vertical Lines
(0..Window.width).step(GRID_SIZE).each do |x|
  Line.new(x1: x, x2: x, y1: 0, y2: Window.height, width: 2, color: GRID_COLOR, z: 1)
end
# Horizontal Lines
(0..Window.height).step(GRID_SIZE).each do |y|
  Line.new(y1: y, y2: y, x1: 0, x2: Window.width, width: 2, color: GRID_COLOR, z: 1)
end


current_line = HEIGHT - 1
current_direction = :right
speed = 4
score = 0


frozen_squares = {}

active_squares = (0..8).map do |index|
  Square.new(
    x: GRID_SIZE * index,
    y: GRID_SIZE * current_line,
    size: GRID_SIZE,
    color: BLOCK_COLOR
  )
end

update do
  if active_squares.empty?
    Text.new("Game over!", size: 30, x: 60, y: 80, z: 2)
    Text.new("Your score: #{score}", size: 30, x: 40, y: 120, z: 2)
  elsif current_line < 0
    if frozen_squares.size == 180
      win1(score)
    else
      win(score)
    end

  else
    if Window.frames % (60 / speed) == 0
      case current_direction
      when :right
        active_squares.each { |square| square.x += GRID_SIZE }
        if active_squares.last.x + active_squares.last.width >= Window.width
          current_direction = :left
        end
      when :left
        active_squares.each { |square| square.x -= GRID_SIZE }
        if active_squares.first.x <= 0
          current_direction = :right
        end
      end
    end
  end
end

on :key_down do
  current_line -= 1
  speed += 2

  active_squares.each do |active_square|
    if current_line == HEIGHT - 2 || frozen_squares.has_key?("#{active_square.x},#{active_square.y + GRID_SIZE}")
      frozen_squares["#{active_square.x},#{active_square.y}"] = Square.new(
        x: active_square.x,
        y: active_square.y,
        color: BLOCK_COLOR,
        size: GRID_SIZE
      )
=begin
    else
      frozen_squares["#{active_square.x},#{active_square.y}"] = Square.new(
        x: active_square.x,
        y: active_square.y,
        color: '#D3D3D3',
        opacity: 0.40,
        size: GRID_SIZE
      )
=end
    end
  end

  active_squares.each(&:remove)
  active_squares = []

  (0..WIDTH).each do |index|
    x = GRID_SIZE * index
    y = GRID_SIZE * current_line

    if frozen_squares.has_key?("#{x},#{y + GRID_SIZE}")
      active_squares.push(Square.new(
        x: x,
        y: y,
        color: BLOCK_COLOR,
        size: GRID_SIZE
      )
    )
    end
  end

  score = frozen_squares.size
end




def win(score)
  Text.new("Game over! You win!", size: 30, x: 60, y: 80, z: 2)
  Text.new("Your score: #{score}", size: 30, x: 40, y: 120, z: 2)
end















































def win1(tmp)
  set width: 800, height: 600

  img = Image.new("images/img.jpg", z: 2)
  # img2 = Image.new("images/img2.jpg", z: 3)
  # img2.x = 200
  # img2.y = 600
  img.x = 100
  img.y = 90
  angle = 0
  speed = 2
  rotation_speed = 1

  update do

    img.x += speed
    img.y += speed



    img.width *= 1.0009
    img.height *= 1.0009

    angle += rotation_speed
    angle = angle % 360 + rand(3)



    # img2.x += speed
    # img2.y += speed
    # img2.width *= 1.0009
    # img2.height *= 1.0009
    img.rotate = angle
    # img2.rotate = angle - 900





    if img.x <= 0 || img.x >= (Window.width - img.width)
      speed *= -1
    end
    if img.y <= 0 || img.y >= (Window.height - img.height)
      speed *= -1
    end


    # if img2.x <= 0 || img2.x >= (Window.width - img.width)
    #   speed *= -1
    # end
    # if img2.y <= 0 || img2.y >= (Window.height - img.height)
    #   speed *= -1
    # end
  end

  Text.new("please please give us a 100.", size: 25, x: 60, y: 80, z: 2)


end
show
