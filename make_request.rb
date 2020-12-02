require "httparty"

class MakeRequest
  def initialize(email, token)
    @email = email
    @token = token
  end

  def headers
    {
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{@token}",
      "User-Agent" => "MyApp (doug@boletosimples.com.br)",
    }
  end

  def create_custumer(body)
    response = HTTParty.post(
      "https://sandbox.boletosimples.com.br/api/v1/customers",
      :body => body.to_json,
      :headers => headers,
    )
    puts(response)
    response.to_h
  end

  def create_bank_billet(body)
    response = HTTParty.post(
      "https://sandbox.boletosimples.com.br/api/v1/bank_billets",
      :body => { "bank_billet": { "amount": 12.34, "expire_at": "2021-11-15", "description": "Prestação de Serviço", "customer_person_name": "Nome do Cliente", "customer_cnpj_cpf": "125.812.717-28", "customer_zipcode": "12312123", "customer_address": "Rua quinhentos", "customer_city_name": "Rio de Janeiro", "customer_state": "RJ", "customer_neighborhood": "bairro" } }.to_json,
      :headers => headers,
    )
    puts(response)
    response
  end

  def create_subscription(body)
    # Assinatura
    response = HTTParty.post(
      "https://sandbox.boletosimples.com.br/api/v1/customer_subscriptions",
      :body => body.to_json,
      :headers => headers,
    )
    puts(response)
    response
  end

  def create_installment(body)
    response = HTTParty.post(
      "https://sandbox.boletosimples.com.br/api/v1/installments",
      :body => body.to_json,
      :headers => headers,
    )
    puts(response)
    response
  end
end
