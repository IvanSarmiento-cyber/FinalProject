require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do 
    before do
      @user = FactoryBot.build(:user)
    end

    context 'When new registration is successful' do
      it 'registers with email, password, and password confirmation' do
        expect(@user).to be_valid
      end
      
      it 'registers with a password of 6 or more characters' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        expect(@user).to be_valid
      end
    end

    context 'When new registration is unsuccessful' do
      it 'does not register if email is blank' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      
      it 'does not register if email is already taken' do
        @user.save
        new_user = FactoryBot.build(:user, email: @user.email)
        new_user.valid?
        expect(new_user.errors.full_messages).to include('Email has already been taken')
      end
      
      it 'does not register if password is blank' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      
      it 'does not register if password confirmation does not match password' do
        @user.password_confirmation = 'nottherightpassword'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it 'does not register if password is 5 characters or fewer' do
        @user.password = '12345'
        @user.password_confirmation = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
    end
  end
end
