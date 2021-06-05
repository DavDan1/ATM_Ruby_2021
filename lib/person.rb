require 'pry'
require './lib/account'
require './lib/atm'
require 'date'

class Person
  attr_accessor :name, :cash, :account

  def initialize(attrs = {})
    set_name(attrs[:name])
    @cash = 0
    @account = nil
  end

  def create_account
    @account = Account.new(owner: self)
  end

  def set_name(obj)
    obj.nil? ? missing_name : @name = obj
  end

  def deposit(amount, atm)
    if @account.nil?
      raise 'No account present'
    else
      @cash -= amount
      atm = Atm.new
      atm.deposit(amount, @account)
    end
  end

  def withdraw(attrs = {})
    atm = attrs[:atm]
    if atm.nil?
      raise 'An ATM is required'
    else
      response = atm.withdraw(attrs[:amount], attrs[:pin], attrs[:account])
      if response[:status] == true
        @cash += attrs[:amount]
        @account.balance -= attrs[:amount]
        response
      else
        response
      end
    end
  end

  private

  def missing_name
    raise 'A name is required'
  end
end
