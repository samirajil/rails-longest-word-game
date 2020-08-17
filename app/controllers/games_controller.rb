require 'json'
require 'open-uri'
require 'byebug'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(9)
  end

  def score
    @answer = params[:answer].upcase
    @letters = params[:letters].split(" ")
    if validword?(@answer) == false && rightword?(@answer, @letters) == true
      @score = 0
      @message = "#{@answer} is not a valid English word"
    elsif rightword?(@answer, @letters) == false && validword?(@answer) == true
      @score = 0
      @message = "#{@answer} is not valid according to the grid"
    elsif rightword?(@answer, @letters) == false && validword?(@answer) == false
      @score = -100
      @message = "#{@answer} is not valid according to the grid and is not a valid word"
    else
      @score = 100
      @message = "Well Done"
    end
  end

  private

  def validword?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    answer = JSON.parse(open(url).read)
    return answer["found"]
  end

  def rightword?(guess, grid)
    guess.chars.all? { |letter| guess.count(letter) <= grid.count(letter) }
  end
end
