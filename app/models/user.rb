class User < ApplicationRecord
  has_secure_password
  has_one :account

  def self.login(login, password, password_confirmation)
    user = User.find_by(login: login)
    if user.present?
      if password == password_confirmation && password == user.password_digest
        return user
      end
    end
  end

  def give_credit(amount, user)
    if self.account.balance - amount.to_f >= 0
      user = User.find_by(login: user)

      if user.blank?
        return {successful: false, message: "User cannot be found"}
      end

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
      self.account.update_column(balance: balance - amount.to_f)
      user.account.update_column(balance: balance + amount.to_f)
      return {successful: false, message: "Transaction made"}
    else
      return {successful: false, message: "Insuficent funds"}
    end
  end

end
