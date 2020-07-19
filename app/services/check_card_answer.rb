# frozen_string_literal: true

require 'damerau-levenshtein'

class CheckCardAnswer
  LEVENSHTEIN_DISTANCE = 3

  MAX_MISTAKE = 3

  attr_reader :user_answer, :card, :quality

  def initialize(args)
    @user_answer = args[:user_answer]
    @card = args[:card]
    @quality = args[:quality]
    @supermemo = SuperMemo.new(card, quality)
  end

  def success?
    checker_success
  end

  def info?
    checker_info
  end

  def error?
    checker_error
  end

  private

  def checker_success
    success_saver if levenshtein_check == 0
  end

  def checker_info
    if levenshtein_check < LEVENSHTEIN_DISTANCE && levenshtein_check != 0
      success_saver
    end
  end

  def checker_error
    if levenshtein_check > LEVENSHTEIN_DISTANCE
      card.mistake_counter += 1
      error_saver
      card.save(touch: false)
    end
  end

  def success_saver
    @supermemo.call
  end

  def error_saver
    if card.mistake_counter == MAX_MISTAKE
      card.mistake_counter = 0
      card.save!
    end
  end

  def levenshtein_check
    DamerauLevenshtein.distance(card[:translated_text].downcase, user_answer.downcase)
  end
end
