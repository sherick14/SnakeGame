# Nos ayuda a incluir archivo a este archivo, como @import de sass
require_relative "views/ruby2d"
require_relative "model/state"
require_relative "actions/actions"

class App
    def initialize
        @state = Model::initial_state
    end

    def start
        @view = View::Ruby2dView.new(self)
        timer_thread = Thread.new { init_timer(@view) }
        @view.start(@state)
        timer_thread.join
    end

    def init_timer(view)
        loop do
            if @state.game_finished
                puts "Game over"
                puts "Score: #{@state.Snake.positions.length}"
                break
            end
            @state = Actions::move_snake(@state)
            view.renderGame(@state)  
            sleep 0.5
        end
    end

    def send_action(action, params)
        
        new_state = Actions.send(action, @state, params)
        if new_state.hash != @state.hash
            @state = new_state
            @view.render(@state)
        end
    end
end

app = App.new
app.start