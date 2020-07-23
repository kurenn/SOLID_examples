# Software entities should be open for extension, but closed for modification

# Example 1

#Solution 1
class Payment
  PAYMENT_GATEWAYS = {
    'conekta' => PaymentGateway::Conekta
    'paypal' => PaymentGateway::Paypal
    'mercado_pago' => PaymentGateway::MercadoPago
  }.freeze

  def initialize(payment_gateway)
    @payment_gateway = payment_gateway
  end

  def perform
    gateway = PAYMENT_GATEWAYS[@payment_gateway].new
    gateway.prepare
    gateway.pay
  end
end

#Solution 2
class Payment
  def perform(payment_gateway: PaymentGateway::Conekta)
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

class PaymentGateway::Conekta
  def prepare
  end

  def pay
  end
end

class PaymentGateway::Paypal
  def prepare
  end

  def pay
  end
end

class PaymentGateway::MercadoPago
  def prepare
  end

  def pay
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

class EmailNotifier
  def notify(user, message)
  end
end

class SmsNotifier
  def notify(user, message)
  end
end
