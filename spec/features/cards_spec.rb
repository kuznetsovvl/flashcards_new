require 'rails_helper'

RSpec.feature "Cards", type: :feature do
  context 'create new card' do
  	before(:each) do
  		visit new_card_path
      find('input#card_original_text').set('foo')
  	end
  	scenario "should be successfull" do
      find('input#card_translated_text').set('bar')      
  		click_button 'Create Card'   		
  		expect(page).to have_content('The card has created successfully')
  	end

    	scenario "should fail" do
  		click_button 'Create Card'     		
  		expect(page).to have_content('Could not save the card')
  	end
  end

  context 'update card' do
  	let(:card) {FactoryBot.create :card}
  	before(:each) do
  		visit edit_card_path(card)
  	end
  	scenario 'should be successful' do
      find('input#card_original_text').set('foo')
	  	click_button 'Update Card'
	  	expect(page).to have_content('The card has updated successfully')
	  end

  	scenario 'should be fail' do
      find('input#card_original_text').set('')
	  	click_button 'Update Card'
	  	expect(page).to have_content('Could not update the card')
	  end
	end	

	context 'destroy card' do
		let(:card) {FactoryBot.create :card}
		before(:each) do
			visit cards_path
		end
		scenario 'should be successful' do
			click_button 'Destroy', match: :first
			expect(page).to have_content('The card was removed successfully')
		end
	end

  context 'trainer card' do
    before(:each) do
      visit cards_path
    end      
    scenario 'should be successfull' do
      find('input#other_user_answer').set('Hello')
      click_button 'Check'
      expect(page).to have_content('Awesome!')
    end
    scenario 'should be fail' do
      find('input#other_user_answer').set('foo')
      click_button 'Check'
      expect(page).to have_content('Try again!')
    end
  end

end