class Stripe::ChargeCustomer
  include Virtus.model

  attribute :amount, Integer
  attribute :stripe_amount, String

  attribute :stripe_customer, String

  def call
    @stripe_charge ||= Stripe::Charge.create(
      amount: amount,
      currency:"cad",
      # customer: stripe_customer.id, obtained with Stripe.js
      # source: params[:stripe_token] use this instead the customer: stripe_customer.id so user don't have to log in
      description: "Payment for pledge id #{pledge.id}"
    )
  end

end
