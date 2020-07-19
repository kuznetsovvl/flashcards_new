# frozen_string_literal: true

require 'damerau-levenshtein'

class SuperMemo
  QUALITY_RANGE = (1..5).freeze
  MIN_RATIO_EASINESS = 1.5
  PERMISSIBLE_QUALITY = 3
  DEFAULT_FIRST_INTERVAL = 1
  DEFAULT_SECOND_INTERVAL = 6

  attr_reader :card, :quality

  def initialize(card, quality)
    @card = card
    @quality = quality.to_i
  end

  def call
    card.easiness = [MIN_RATIO_EASINESS, card.easiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))].max
    set_repetitions_counter
    interval_counter
    set_review_time
    card.save!
  end

  private

  def set_repetitions_counter
    quality <= PERMISSIBLE_QUALITY ? card.repetitions = 0 : card.repetitions += 1
  end

  def interval_counter
    result = if card.repetitions <= 1
               DEFAULT_FIRST_INTERVAL
             elsif card.repetitions == 2
               DEFAULT_SECOND_INTERVAL
             else
               card.interval * card.easiness
            end
    card.interval = result
  end

  def set_review_time
    card.review_time = Time.now + card.interval.day
  end
end
