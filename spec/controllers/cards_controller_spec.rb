# frozen_string_literal: true

require 'rails_helper'

describe 'Routing', type: :routing do
  it do
    should route(:get, '/cards', port: 3000).
      to('cards#index')
  end
end