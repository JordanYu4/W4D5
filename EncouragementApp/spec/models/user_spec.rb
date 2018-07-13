# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'
require 'spec_helper'
require 'shoulda/matchers'

RSpec.describe User, type: :model do

  subject(:user) { User.create!(username: 'bob', password: '123456') }

  it { should validate_uniqueness_of(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:session_token) }
  it { should validate_presence_of(:password_digest) }

  it { should have_many(:goals) }
  it { should have_many(:cheers) }
  it { should have_many(:comments) }

  describe '#ensure_session_token' do
    it 'ensures a session token not to be nil' do
      expect(user.session_token).not_to be_nil
    end
  end

  describe '#reset_session_token!' do
    it 'resets the user\'s session_token' do
      old_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_token)
    end
  end

  describe '::find_by_credentials' do
    subject(:bob) { User.create!(username: 'bob', password: '123456')}
    it 'returns nil if credentials do not match user' do
      expect(User.find_by_credentials('Chad', '1234567')).to be_nil
    end

    it 'returns nil if password does not match user' do
      expect(User.find_by_credentials('bob', '1234567')).to be_nil
    end

    it 'returns user if credentials match user' do
      bob.save!
      
      expect(User.find_by_credentials('bob', '123456')).to eq(bob)
    end
  end




end
