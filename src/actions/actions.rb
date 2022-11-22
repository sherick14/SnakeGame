module Actions
    def self.move_snake(state)
        next_direction = state.Current_direction
        next_position = calc_next_position(state)
        # verificate next celd it's validate
        if position_is_food?(state, next_position)
            state = grow_snake_to(state, next_position)
            generate_food(state)
        elsif position_is_valid?(state, next_position)
        #if is validate move the snake 
            move_snake_to(state, next_position)
        #else end the game
        else
            end_game(state)
        end
    end

    def self.change_direction(state, direction)
        if next_direction_is_valid?(state, direction)
            state.Current_direction = direction
        else
            puts "Invalid direction"
        end
        state
    end

    private

    def self.generate_food(state)
        new_food = Model::Food.new(rand(state.Grid.rows), rand(state.Grid.cols))
        state.Food = new_food
        state
    end

    def self.position_is_food?(state, next_position)
        state.Food.row == next_position.row && state.Food.col == next_position.col
    end

    def self.grow_snake_to(state, position)
        state.Snake.positions = [position] + state.Snake.positions
        state
    end

    # def self.grow_snake_to(state, next_position)
    #     new_snake = [next_position] + state.Snake
    #     state.Snake = new_snake
    #     state
    # end

    def self.calc_next_position(state)
        curr_position = state.Snake.positions.first
        case state.Current_direction
            when Model::Direction::UP 
                return Model::Coord.new(curr_position.row-1, curr_position.col )
            when Model::Direction::RIGHT 
                return Model::Coord.new(curr_position.row, curr_position.col+1)
            when Model::Direction::DOWN 
                return Model::Coord.new(curr_position.row+1, curr_position.col )
            when Model::Direction::LEFT 
                return Model::Coord.new(curr_position.row, curr_position.col-1)
        end
    end

    def self.position_is_valid?(state, position)
        is_invalid = ((position.row >= state.Grid.rows || position.row < 0) || (position.col >= state.Grid.cols || position.col < 0))

        return false if is_invalid

        return !(state.Snake.positions.include? position)
    end

    def self.move_snake_to(state, next_position)
        new_positions = [next_position] + state.Snake.positions[0...-1]
        state.Snake.positions = new_positions
        state
    end

    def self.end_game(state)
        state.game_finished = true
        state
    end

    def self.next_direction_is_valid?(state, direction)
        case state.Current_direction
        when Model::Direction::UP
            return true if direction != Model::Direction::DOWN    
        when Model::Direction::DOWN
            return true if direction != Model::Direction::UP    
        when Model::Direction::RIGHT
            return true if direction != Model::Direction::LEFT    
        when Model::Direction::LEFT
            return true if direction != Model::Direction::RIGHT    
        end

        return false

    end

end



  