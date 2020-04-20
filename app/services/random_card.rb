# frozen_string_literal: true

require 'damerau-levenshtein'

class RandomCard
  CHECKS = { 0 => proc { 2.seconds.ago },
             1 => proc { 12.hours.ago },
             2 => proc { 3.days.ago.to_date },
             3 => proc { 7.days.ago.to_date },
             4 => proc { 2.weeks.ago.to_date },
             5 => proc { 1.month.ago.to_date } }.freeze

  MAX_MISTAKE = 3
  LEVENSHTEIN_DISTANCE = 3

  def today_card(user)
    @current_decks = Deck.where(user_id: user.id).last
    @new_array = (0..5).map { |e| e = check(e) }
    @new_array.compact.last
  end

  def trainer_correct_answer(card, params)
    @dl = DamerauLevenshtein
    @card = card
    if @dl.distance(card[:translated_text].downcase, params.downcase) == 0
      trainer_correct_saver
    end
  end

  def trainer_correct_with_mistake(card, params)
    @dl = DamerauLevenshtein
    @card = card
    if @dl.distance(card[:translated_text].downcase, params.downcase) < LEVENSHTEIN_DISTANCE
      trainer_correct_saver
    end
  end

  def trainer_wrong_answer(card)
    card.mistake_counter += 1
    if card.mistake_counter == MAX_MISTAKE
      card.status = 0
      card.mistake_counter = 0
      card.save!
    end
  end

  def trainer_save(card)
    card.save!(touch: false)
  end

  def trainer_correct_saver
    @card.status += 1
    @card.mistake_counter = 0
    @card.save!
  end

  private

  def check(number)
    Card.where(deck_id: @current_decks&.id).where('updated_at <= ?', CHECKS[number].call).where('status = ?', number).last
  end
end
