class Payments::HandlePayment < Service::Base
  attribute :pledge, Pledge
  attribute :stripe_token, String
  attribute :user, User

  def call
    # creates stripe customer
    # save customer id in the database
    # makes stripe charge
    # saves transaction id in the database
    stripe_customer &&
      set_user_stripe_customer_id &&
      stripe_charge &&
      set_pledge_stripe_txn_id
  end

  private

  def stripe_customer
    if @stripe_customer
      @stripe_customer
    else
      service = Stripe::CreateCustomer.new description: stripe_customer_description,
                                           stripe_token: stripe_token
      @stripe_customer = service.stripe_customer if service.call
    end
  end

  def stripe_customer_description
    "Customer for #{user.email}"
  end

  def set_user_stripe_customer_id
    user.stripe_customer_id = stripe_customer.id
    user.save
  end

  def stripe_charge
    if @stripe_charge
      @stripe_charge
    else
      service = Stripe::ChargeCustomer.new amount: charge_amount,
                                           stripe_customer_id: stripe_customer.id,
                                           description: charge_description
      @stripe_charge = service.stripe_charge if service.call
    end
  end

  def charge_amount
    (pledge.amount * 100).to_i
  end

  def charge_description
    "Payment for pledge id #{pledge.id}"
  end

  def set_pledge_stripe_txn_id
    pledge.stripe_txn_id = stripe_charge.id
    pledge.save
  end
end
