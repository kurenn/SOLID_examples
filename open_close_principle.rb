# Software entities should be open for extension, but closed for modification

# Example 1
class Payment
  def initialize(payment_gateway)
    @payment_gateway = payment_gateway
  end

  def perform
    case @payment_gateway
    when 'conekta'
      gateway = PaymentGateway::Conekta.new
      gateway.prepare
      gateway.pay
    when 'paypal'
      gateway = PaymentGateway::Paypal.new
      gateway.prepare
      gateway.pay
    when 'mercado_pago'
      gateway = PaymentGateway::MercadoPago.new
      gateway.prepare
      gateway.pay
    end
  end
end

class NilPaymentGateway
  def prepare
  end

  def pay
  end
end

module Constants
  module Messages
  end
  module Payments
    GATEWAYS = {
      'conekta' => PaymentGateway::Conekta
      'paypal' => PaymentGateway::Paypal
      'mercado_pago' => PaymentGateway::MercadoPago
    }.freeze

    DEFAULT_GATEWAY = NilPaymentGateway
  end
end

class Payment
  def initialize(payment_gateway)
    @payment_gateway = payment_gateway
  end

  def perform
    gateway.perform
  end

  private

  def gateway
    @gateway ||= (Constants::PAYMENT_GATEWAYS[@payment_gateway] || DEFAULT_GATEWAY).new
  end
end

class Payment
  def perform(payment_gateway: PaymentGateway::Conekta.new)
    payment_gateway.prepare
    payment_gateway.pay
  end
end

class PaymentGateway::Base
  def prepare
    raise NotImplementedError
  end

  def pay
    raise NotImplementedError
  end
end

class PaymentGateway::Paypal < PaymentGateway::Base
  def perform
    validate
    prepare
    pay
  end
end

class PaymentGateway::Conekta < PaymentGateway::Base
  def perform
    prepare
    pay
  end
end

# Example 2
class User
  def notifiable?
    true
  end
end

class Notifier
  def notify(user, message, notifier = EmailNotifier.new)
    notifier.notify(user, message) if user.notifiable?
  end
end

class Notifier
  def notify(user, message)
    if user.notifiable?
      if user.sms?
        SmsNotifier.new.notify(user, message)
      else
        EmailNotifier.new.notify(user, message)
      end
    end
  end
end

class PushNotificationNotifier
  def notify(user, message)
  end
end

class EmailNotifier
  def notify(user, message)
  end
end

class SmsNotifier
  def notify(user, message)
  end
end
