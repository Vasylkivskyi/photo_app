class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year
  belongs_to :user

  def self.month_options
    Date::MONTH_NAMES.compact.each_with_index { |month, i| ["#{i + 1} - #{month}", i+1]}
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def proccess_payment
    customer = Stripe::Customer.create(email: email, card: token)
    Stripe::Charge.create(
      customer: customer.id,
      amount: 1000,
      description: "Premium",
      currency: 'usd'
    )
  end
end
