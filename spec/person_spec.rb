require './lib/person'
require './lib/atm'
require './lib/account'
require 'date'

describe Person do
  subject { described_class.new(name: 'Dav') }

  it 'is expected to have a :name on initialize' do
    expect(subject.name).not_to be nil
  end

  it 'is expected to raise error if no name is set' do
    expect { described_class.new }.to raise_error 'A name is required'
  end

  it 'is expected to have a :cash attribute with the value of 0 on initialize' do
    expect(subject.cash).to eq 0
  end

  it 'is expected to have a :account attribute ' do
    expect(subject.account).to be nil
  end

  describe 'can create an Account' do
    before { subject.create_account }

    it 'of Account class ' do
      expect(subject.account).to be_an_instance_of Account
    end

    it 'with himself as an owner' do
      expect(subject.account.owner).to be subject
    end
  end

  describe 'can manage funds if an account been created' do
    let(:atm) { Atm.new }

    before { subject.create_account }
    it 'can deposit funds' do
      expect(subject.deposit(100, atm)).to be_truthy
    end

    it 'funds are added to the account balance - deducted from cash' do
      subject.cash = 100
      subject.deposit(100, atm)
      expect(subject.account.balance).to be 100
      expect(subject.cash).to be 0
    end

    it 'can withdraw funds' do
      command = lambda {
        subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm)
      }
      expect(command.call).to be_truthy
    end

    it 'withdraw is expected to raise an error if no ATM is passed in' do
      command = -> { subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account) }
      expect { command.call }.to raise_error 'An ATM is required'
    end

    it 'fund are added to cash - deducted from account balance' do
      subject.cash = 100
      subject.deposit(100, atm)
      subject.withdraw(amount: 100, pin: subject.account.pin_code, account: subject.account, atm: atm)
      expect(subject.account.balance).to be 0
      expect(subject.cash).to be 100
    end
  end

  describe 'can not manage funds if no account been created' do
    let(:atm) { Atm.new } # didn't have it in documentation, but why not??

    it 'can\'t deposit funds' do
      expect { subject.deposit(100, atm) }.to raise_error(RuntimeError, 'No account present')
    end
  end
end
