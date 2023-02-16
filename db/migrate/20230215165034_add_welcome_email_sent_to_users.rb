class AddWelcomeEmailSentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :welcome_email_sent, :boolean, default: false
  end
end
