class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  attr_accessor :word, :guesses, :wrong_guesses
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter)
    raise ArgumentError, 'Input cannot be nil' if letter.nil?

    raise ArgumentError unless /[a-z]/i.match(letter)

    raise ArgumentError, 'Input was not a letter' if letter == ''

    letter.downcase!
    
    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses += letter unless @guesses.include?(letter)
      true
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses += letter unless @wrong_guesses.include?(letter)
      true

    else
      false
    end
  end

  def word_with_guesses
    word.gsub(/./) { |match| @guesses.include?(match) ? match : '-' }
  end

   def check_win_or_lose
    if word_with_guesses == word
      :win
    elsif wrong_guesses.length >= 7
      :lose
    else
      :play
    end
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end