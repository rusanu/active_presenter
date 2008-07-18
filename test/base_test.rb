require File.dirname(__FILE__)+'/test_helper'

Expectations do
  expect :user => User, :account => Account do
    SignupPresenter.presented
  end
  
  expect User.create!(hash_for_user) do |u|
    SignupPresenter.new(:user => u.expected).user
  end
  
  expect User do
    SignupPresenter.new.user
  end
  
  expect User.any_instance.to.receive(:login=).with('james') do
    SignupPresenter.new(:user_login => 'james')
  end
  
  expect 'mymockvalue' do
    User.any_instance.stubs(:login).returns('mymockvalue')
    SignupPresenter.new.user_login
  end
  
  expect User.any_instance.to.receive(:login=).with('mymockvalue') do
    SignupPresenter.new.user_login = 'mymockvalue'
  end
  
  expect SignupPresenter.new.not.to.be.valid?
  expect SignupPresenter.new(:user => User.new(hash_for_user)).to.be.valid?
  
  expect ActiveRecord::Errors do
    s = SignupPresenter.new
    s.valid?
    s.errors
  end
end
