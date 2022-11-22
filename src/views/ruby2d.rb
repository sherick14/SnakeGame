require "ruby2d"
require_relative "../model/state"

module View
    class Ruby2dView 

        def initialize
            @pixel_size = 50
        end

        def start (state)
            extend Ruby2D::DSL
            set(
                title: "Snake", 
                width: @pixel_size * state.Grid.cols, 
                height: @pixel_size * state.Grid.rows)
            show
        end

        def renderGame(state)
            render_food(state)
            render_snake(state)
        end

        private
        def render_food(state)
            @food.remove if @food
            extend Ruby2D::DSL
            food = state.Food
            @food = Square.new(
                x: food.col * @pixel_size, 
                y: food.row * @pixel_size,
                size: @pixel_size,
                color: 'orange',
            )
        end

        def render_snake(state)  
            @snake_positions.each(&:remove) if @snake_positions
            extend Ruby2D::DSL
            snake = state.Snake
            @snake_positions = snake.positions.map do |pos|
                Square.new(
                    x: pos.col * @pixel_size, 
                    y: pos.row * @pixel_size,
                    size: @pixel_size,
                    color: 'blue',
                )
            end
        end
    end
end