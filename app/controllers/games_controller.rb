require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    # @letters = 10.times { puts ('a'..'z').to_a.sample }
    @letters = generate_letters(10).join
  end

  def letter_generated
    @answer.chars.each do |letter|
      @letters.include?(letter)
    end
  end

  def english_word
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    word = JSON.parse(open(url).read)
    return word['found']
  end

  def score
    @answer = params[:word]
    if !letter_generated
      @result = "Sorry, #{@answer} cannot be built out of #{@letters}"
    elsif english_word
    @result = "Congratulations! #{@answer.upcase} is a valid word."
  end

  private

  def generate_letters(number_of_letters)
    Array.new(number_of_letters) { ('A'..'Z').to_a[rand(26)] }
  end
end
