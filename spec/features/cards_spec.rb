require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  context 'create new user' do
  	before(:each) do
  		visit new_card_path
  		within('form') do
  			fill_in 'Original text', with: 'Hola'
  		end
  	end
  	scenario "should be successfull" do
  		within('form') do
  			fill_in 'Translated text', with: 'Heloo'  			
  		end
  		click_button 'Create Card'   		
  		expect(page).to have_content('Edit')
  	end

    	scenario "should fail" do
  		click_button 'Create Card'     		
  		expect(page).to have_content('prohibited this article from being saved')
  	end
  end

  context 'update user' do
  	let(:card) {FactoryBot.create :card}
  	before(:each) do
  		visit edit_card_path(card)
  	end
  	scenario 'should be successful' do
	  	within('form') do
	  		fill_in 'Original text', with: 'Bailar'
	  	end
	  	click_button 'Update Card'
	  	expect(page).to have_content('Edit')
	  end

  	scenario 'should be fail' do
	  	within('form') do
	  		fill_in 'Original text', with: ''
	  	end
	  	click_button 'Update Card'
	  	expect(page).to have_content('prohibited this article from being saved')
	  end
	end		
end