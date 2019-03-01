class Admin < User
  def create_user(username, password)
    new_user = User.new
    new_user.login = username
    new_user.password = password
    new_user.password_confirmation = password
    new_user.save
  end

  def admin_transfer(amount, user)
    user = User.find_by(login: user)
    transaction = user.account.transaction.new
    transaction.amount = amount
    transaction.from_id = self.id
    transaction.to_id = user.id
    transaction.type = 'Credit'
    transaction.save

    user.account.update_column(balance: balance + amount)
  end
end
