# frozen_string_literal: true

module Sorcery
  module TestHelpers
    module Rails
      module Integration
        def login_user_post(user, password, password_confirmation)
          page.driver.post(user_sessions_url, email: user, password: password, password_confirmation: password_confirmation)
        end
      end
    end
  end
end
