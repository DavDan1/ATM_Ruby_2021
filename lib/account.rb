require './lib/atm'

class Account
  STANDARD_VALIDITY_YEARS = 5
  attr_reader :pin_code, :exp_date, :owner
  attr_accessor :account_status, :balance

  def set_expire_date
    Date.today.next_year(Account::STANDARD_VALIDITY_YEARS).strftime('%m/%y')
  end

  def initialize(attrs = {})
    @pin_code = rand(1000..9999)
    @exp_date = set_expire_date
    @account_status = :active
    @balance = 0
    set_owner(attrs[:owner])
  end

  def self.deactivate(account)
    account.account_status = :deactivated
  end

  def deactivate
    @account_status = :deactivated
  end

  private

  def set_owner(obj)
    obj.nil? ? missing_owner : @owner = obj
  end

  def missing_owner
    raise 'An Account owner is required'
  end
end
