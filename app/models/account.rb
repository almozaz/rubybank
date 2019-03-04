class Account < ApplicationRecord
  belongs_to :user
  has_many :transactions

  def new_transaction
    new_transaction = Transaction.new
    new_transaction.account_id = self
    
    return new_transaction
  end
end
