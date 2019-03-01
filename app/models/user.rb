class User < ApplicationRecord
  has_secure_password
  has_one :account

  def login(password, password_confirmation)
    password == password_confirmation
  end

  def give_credit(amount, user)
    if self.account.balance - amount >= 0
      user = User.find_by(login: user)
      user_transaction = user.account.transaction.new
      user_transaction.amount = amount
      user_transaction.from_id = self.id
      user_transaction.to_id = user.id
      user_transaction.type = 'Credit'
      user_transaction.save

      transaction = self.account.transaction.new
      transaction.amount = amount
      transaction.from_id = self.id
      transaction.to_id = user.id
      transaction.type = 'Debit'
      transaction.save
      self.account.update_column(balance: balance - amount)
      user.account.update_column(balance: balance + amount)
    else
      return "Insuficent funds"
    end
  end

end
