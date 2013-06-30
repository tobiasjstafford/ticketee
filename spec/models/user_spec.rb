require 'spec_helper'

describe User do
  it "requires an email to be valid" do
    u = User.new(name: 'toby',
                 password: 'password',
                 password_confirmation: 'password')
    u.save
    expect(u).to_not be_valid

    u.email = 'toby@example.com'
    u.save
    expect(u).to be_valid
  end

  describe "passwords" do
    it "requires password confirmation" do
      u = User.new(name: 'toby', email: 'toby@example.com')

      u.save
      expect(u).to_not be_valid

      u.password = 'password'
      u.password_confirmation = ''

      u.save
      expect(u).to_not be_valid

      u.password_confirmation = 'password'

      u.save
      expect(u).to be_valid
    end

    it "needs password and password confirmation to match" do
      u = User.new(name: 'toby',
                   email: 'toby@example.com',
                   password: 'password',
                   password_confirmation: 'password2')

      u.save
      expect(u).to_not be_valid
    end
  end

  describe "authentication" do
    let(:user) { User.create(name: 'toby',
                             password: 'password',
                             password_confirmation: 'password') }

    it "authenticates with a valid password" do
      expect(user.authenticate("password")).to be
    end

    it "does not authenticate with an invalid password" do
      expect(user.authenticate("password2")).to_not be
    end
  end
end
