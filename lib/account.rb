class Account
  STANDARD_VALIDITY_YEARS = 5

  def set_expire_date
    Date.today.next_year(Account::STANDARD_VALIDITY_YEARS).strftime('%m/%y')
  end

  def initialize
    @account_status = :active
  end

  def self.deactivate(account)
    account.account_status= :deactivated
  end

  def deactivate
    @account_status = :deactivated
    
  end
end
