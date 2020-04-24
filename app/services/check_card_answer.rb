# frozen_string_literal: true

require 'damerau-levenshtein'

class CheckCardAnswer
  LEVENSHTEIN_DISTANCE = 3

  MAX_MISTAKE = 3

  attr_reader :params, :card
  def initialize(params, card)
    @params = params
    @card = card
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
    card.status += 1
    card.mistake_counter = 0
    card.save
  end

  def error_saver
    if card.mistake_counter == MAX_MISTAKE
      card.status = 0
      card.mistake_counter = 0
      card.save
    end
  end

  def levenshtein_check
    @dl = DamerauLevenshtein
    @dl.distance(card[:translated_text].downcase, params.downcase)
  end
end
