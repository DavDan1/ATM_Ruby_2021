require './lib/person'
class Atm
  attr_accessor :funds

  def initialize
    @funds = 1000
  end

  def withdraw(amount, pin_code, account)
    if insufficient_funds_in_account?(amount, account)
      { status: false, message: 'insuificent funds in account', date: Date.today }
    elsif insufficient_funds_in_atm?(amount, account)
      { status: false, message: 'insuificient funds in ATM', date: Date.today }
    elsif incorrect_pin?(pin_code, account.pin_code)
      { status: false, message: 'wrong pin', date: Date.today }
    elsif card_expired?(account.exp_date)
      { status: false, message: 'card expired', date: Date.today }
    elsif account_active?(account.account_status)
      { status: false, message: 'account disabled', date: Date.today }
    else
      perform_transaction(amount, account)
    end
  end

  private

  def insufficient_funds_in_account?(amount, account)
    amount > account.balance
  end

  def deposit(amount, account)
    account.balance += amount
    @funds += amount
  end

  def insufficient_funds_in_atm?(amount, _account)
    @funds < amount
  end

  def incorrect_pin?(pin_code, actual_pin)
    pin_code != actual_pin
  end

  def card_expired?(exp_date)
    Date.strptime(exp_date, '%m/%y') < Date.today
  end

  def account_active?(account_status)
    account_status != :active
  end

  def perform_transaction(amount, account)
    @funds -= amount
    account.balance = account.balance - amount
    { status: true, message: 'success', date: Date.today, amount: amount, bills: add_bills(amount) }
  end

  def add_bills(amount)
    denominations = [20, 10, 5]
    bills = []
    denominations.each do |bill|
      while amount - bill >= 0
        amount -= bill
        bills << bill
      end
    end
    bills
  end
end
