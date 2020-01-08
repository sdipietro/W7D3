require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }

  it { should have_many(:goals) }

  describe 'uniqueness' do 
    before(:each) do 
      FactoryBot.create(:user)
    end
  it { should validate_uniqueness_of(:username) }
  end

  #find by credentials 
  describe 'find by credentials' do 
    it 'with the correct & valid credentials, it should fine the matching user' do
    user = User.create!(username: 'hello', password: '1234567')
    expect(User.find_by_credentials('hello', '1234567')).to eq(user)
    end

    it 'should return nil if given the incorrect username and password' do
    user = User.create!(username: 'hello', password: '1234567')
    expect(User.find_by_credentials('laskdjf', 'alskdfjw')).to be(nil) 
    end


  end

end
