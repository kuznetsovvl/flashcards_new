# frozen_string_literal: true

class NotificationsMailer < ApplicationMailer
  default from: I18n.t('mailer.pending_cards.default')

  def pending_cards(user)
    @user = user
    mail to: user.email, subject: t('mailer.pending_cards.subject')
  end
end
