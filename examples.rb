require_relative "./make_request"
require "faker"

api = MakeRequest.new(ENV["EMAIL"], ENV["TOKEN"])

# Create custumer
cpf = Faker::IDNumber.brazilian_citizen_number(formatted: true)
request_body = { :customer => { "person_name": "Nome do Cliente", "cnpj_cpf": cpf, "zipcode": "20071004", "address": "Rua quinhentos", "city_name": "Rio de Janeiro", "state": "RJ", "neighborhood": "bairro" } }
custumer = api.create_custumer(request_body)
puts("Custumer:")
puts(custumer)

# Create boleto / Bank Billet
request_body = { "bank_billet": { "amount": 12.34, "expire_at": "2021-11-15", "description": "Prestação de Serviço", "customer_person_name": "Nome do Cliente", "customer_cnpj_cpf": "125.812.717-28", "customer_zipcode": "12312123", "customer_address": "Rua quinhentos", "customer_city_name": "Rio de Janeiro", "customer_state": "RJ", "customer_neighborhood": "bairro" } }
bank_billet = api.create_bank_billet(request_body)
puts("Boleto / Bank Billet")
puts(bank_billet)

# Create subscription
request_body = { "customer_subscription": { "customer_id": custumer["id"], "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "description": "Hospedagem" } }
subscription = api.create_subscription(request_body)
puts("Subscription:")
puts(subscription)

# Create installment
request_body = { "installment": { "customer_id": custumer["id"], "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "start_at": "2021-09-15", "total": "3", "description": "Hospedagem" } }
installment = api.create_installment(request_body)
puts("Installment:")
puts(installment)
