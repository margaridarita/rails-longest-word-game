require "open-uri"

class GamesController < ApplicationController

  VOWELS = %w(A E I O U Y)

  def new
    @letters = Array.new(5) { VOWELS.sample }
    @letters += Array.new(5) { (('A'..'Z').to_a - VOWELS).sample }
    @letters.shuffle
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase.gsub(/\s+/, '')
    if @word.blank?
      flash[:error] = 'You must enter a word'
      render :new and return # the rest of the method won't be read
    end
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end

end
