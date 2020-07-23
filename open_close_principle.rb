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

# Example 2
class User
  def notifiable?
    true
  end
end

class Notifier
  def notify(user, message)
    EmailNotifier.notify(user, message) if user.notifiable?
  end
end
