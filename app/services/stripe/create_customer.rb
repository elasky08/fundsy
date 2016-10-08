class Stripe::CreateCustomer
  include Virtus.model

  attribute :description, String
  attribute :stripe_token, String
  attribute :stripe_customer

  def call
    begin
      @stripe_customer ||= Stripe::Customer.create(
        description: "Customer for #{user.email}",
        source: stripe_token# single use token from Stripe.js
      )
    rescue Stripe::StripeError => e
      # show error message 1
      false
    rescue => e
      # notify admin
      false
    end
  end

end
