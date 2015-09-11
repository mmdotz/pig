
require_relative './player'

class Pig
  def initialize
    @players   = []
    @max_score = 12
  end

  def get_players
    puts "Getting player names. Type q when done."
    loop do
      print "Player #{@players.count + 1}, what is your name? > "
      input = gets.chomp
      if input == "q" || input == ""
        return
      else
        player = Player.new(input)
        @players.push player
        #new instance of Scoreboard with all players populating score.name
        #cannot create new instance: uninitialized constant error
        sb = Scoreboard.new
        sb.find_or_create_by(name: player.name)
        sb.save
      end

    end
  end

  def play_round
    @players.each do |p|
      puts "-" * 20
      puts "\n\nIt is #{p.name}'s turn! You have #{p.score} points. (Press ENTER)"
      gets
      take_turn p
    end
    remove_losing_players!
  end

  def remove_losing_players!
    #before kicking out, add players scores to scoreboard
    if @players.any? { |p| p.score > @max_score }
      #then call a win
      #this code allows game to run but doesn't populate scoreboard
      # sb = Scoreboard.new
      # sb.find_or_create_by(wins: 1)
      # binding pry
      max_score = @players.map { |p| p.score }.max
      #anyone who doesn't have max.score create loss
      @players = @players.select { |p| p.score == max_score }
    end
  end

  def winner
    if @players.length == 1
      @players.first
    end
  end

  def take_turn player
    turn_total = 0
    loop do
      roll = rand 1..6
      if roll == 1
        puts "You rolled a 1. No points for you!"
        return
      else
        turn_total += roll
        puts "You rolled a #{roll}. Turn total is #{turn_total}. Again? (y/n)"
        if gets.chomp.downcase == "n"
          puts "Stopping with #{turn_total} for the turn."
          player.score += turn_total
          return
        end
      end
    end
  end

  #sb = Scoreboard.new
  #sb.name = player.name
  #sb.score = player.score
  #before updating a record, retrieve with find_by

end
