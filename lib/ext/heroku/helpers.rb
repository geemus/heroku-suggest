module Heroku
  module Helpers

    def error(msg)
      if msg =~ /(\S*) is not a heroku command. See 'heroku help'./
        command = $1
        distances = {}
        (commands.keys + command_aliases.keys).each do |suggestion|
          distance = string_distance(command, suggestion)
          distances[distance] ||= []
          distances[distance] << suggestion
        end
        STDERR.puts(" !    '#{command}' is not a heroku command.")
        minimum = distances.keys.min
        if minimum < 4
          suggestions = distances[distances.keys.min]
          if suggestions.length == 1
            STDERR.puts(" !    Perhaps you meant '#{suggestions.first}'.")
          else
            STDERR.puts(" !    Perhaps you meant #{suggestions[0...-1].map {|suggestion| "'#{suggestion}'"}.join(', ')} or '#{suggestions.last}'.")
          end
        end
        STDERR.puts(" !    See 'heroku help' for additional details.")
      else
        STDERR.puts(msg)
      end
      exit 1
    end

    private

    def string_distance(first, last)
      distances = [] # 0x0s
      0.upto(first.length) do |index|
        distances << [index] + [0] * last.length
      end
      distances[0] = 0.upto(last.length).to_a
      1.upto(last.length) do |last_index|
        1.upto(first.length) do |first_index|
          first_char = first[first_index - 1, 1]
          last_char = last[last_index - 1, 1]
          if first_char == last_char
            distances[first_index][last_index] = distances[first_index - 1][last_index - 1] # noop
          else
            distances[first_index][last_index] = [
              distances[first_index - 1][last_index],     # deletion
              distances[first_index][last_index - 1],     # insertion
              distances[first_index - 1][last_index - 1]  # substitution
            ].min + 1 # cost
            if first_index > 1 && last_index > 1
              first_previous_char = first[first_index - 2, 1]
              last_previous_char = last[last_index - 2, 1]
              if first_char == last_previous_char && first_previous_char == last_char
                distances[first_index][last_index] = [
                  distances[first_index][last_index],
                  distances[first_index - 2][last_index - 2] + 1 # transposition
                ].min
              end
            end
          end
        end
      end
      distances[first.length][last.length]
    end

  end
end
