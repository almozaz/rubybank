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

  def give_credit(user, amount)  
    if user == self.login
      return {successful: false, message: "You cannot give money to yourself"}
    end

    if self.account.balance - amount.to_f >= 0
      user = User.find_by(login: user)

      if user.blank?
        return {successful: false, message: "User cannot be found"}
      end

      user_transaction = user.account.new_transaction
      user_transaction.amount = amount.to_f
      user_transaction.from_id = self.id
      user_transaction.to_id = user.id
      user_transaction.transaction_type = 'Credit'
      user_transaction.account_id = user.account.id
      user_transaction.save

      transaction = self.account.new_transaction
      transaction.amount = amount.to_f
      transaction.from_id = self.id
      transaction.to_id = user.id
      transaction.transaction_type = 'Debit'
      transaction.account_id = self.account.id
      transaction.save


      self.account.update_column(:balance, self.account.balance - amount.to_f)
      user.account.update_column(:balance, self.account.balance + amount.to_f)

      return {successful: false, message: "Transaction made"}
    else
      return {successful: false, message: "Insuficent funds"}
    end
  end

end
