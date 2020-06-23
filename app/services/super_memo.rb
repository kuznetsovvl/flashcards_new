# frozen_string_literal: true

require 'damerau-levenshtein'

class SuperMemo
  attr_reader :card, :quality

  def initialize(card, quality)
    @card = card
    @quality = quality.to_i
  end

  def call
    card.easiness = [1.5, card.easiness + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02))].max
    set_repetitions_counter
    interval_counter
    set_review_time
    card.save!
  end

  private

  def set_repetitions_counter
    quality <= 3 ? card.repetitions = 0 : card.repetitions += 1
  end

  def interval_counter
    if card.repetitions <= 1
      interval = 1
    elsif card.repetitions == 2
      interval = 6
    else card.repetitions
         interval *= card.easiness
    end
    card.interval = interval
  end

  def set_review_time
    card.review_time = Time.now + card.interval.day
  end
end
