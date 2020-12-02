require "spec_helper"
require_relative "./../make_request"

RSpec.describe MakeRequest do
  let (:subject) { MakeRequest.new(ENV["EMAIL"], ENV["TOKEN"]) }

  describe "create_custumer" do
    context "valid" do
      it "cpf formatted" do
        cpf = Faker::IDNumber.brazilian_citizen_number(formatted: true)
        body = { :customer => { "person_name": "Nome do Cliente", "cnpj_cpf": cpf, "zipcode": "20071004", "address": "Rua quinhentos", "city_name": "Rio de Janeiro", "state": "RJ", "neighborhood": "bairro" } }
        expect(subject.create_custumer(body)).to have_key("id")
      end

      it "cpf unformatted" do
        cpf = Faker::IDNumber.brazilian_citizen_number(formatted: false)
        body = { :customer => { "person_name": "Nome do Cliente", "cnpj_cpf": cpf, "zipcode": "20071004", "address": "Rua quinhentos", "city_name": "Rio de Janeiro", "state": "RJ", "neighborhood": "bairro" } }
        expect(subject.create_custumer(body)).to have_key("id")
      end
    end
  end

  describe "create_bank_billet" do
    it "valid" do
      body = { "bank_billet": { "amount": 12.34, "expire_at": "2021-11-15", "description": "Prestação de Serviço", "customer_person_name": "Nome do Cliente", "customer_cnpj_cpf": "125.812.717-28", "customer_zipcode": "12312123", "customer_address": "Rua quinhentos", "customer_city_name": "Rio de Janeiro", "customer_state": "RJ", "customer_neighborhood": "bairro" } }
      expect(subject.create_bank_billet(body)).to have_key("id")
    end
  end

  describe "create_subscription" do
    it "valid" do
      cpf = Faker::IDNumber.brazilian_citizen_number(formatted: true)
      body = { :customer => { "person_name": "Nome do Cliente", "cnpj_cpf": cpf, "zipcode": "20071004", "address": "Rua quinhentos", "city_name": "Rio de Janeiro", "state": "RJ", "neighborhood": "bairro" } }
      custumer = subject.create_custumer(body)

      body = { "customer_subscription": { "customer_id": custumer["id"], "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "description": "Hospedagem" } }
      expect(subject.create_subscription(body)).to have_key("id")
    end

    it "invalid custumer valid" do
      body = { "customer_subscription": { "customer_id": "0", "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "description": "Hospedagem" } }
      expect(subject.create_subscription(body)).to have_key("errors")
    end
  end

  describe "create_installment" do
    it "valid" do
      cpf = Faker::IDNumber.brazilian_citizen_number(formatted: true)
      body = { :customer => { "person_name": "Nome do Cliente", "cnpj_cpf": cpf, "zipcode": "20071004", "address": "Rua quinhentos", "city_name": "Rio de Janeiro", "state": "RJ", "neighborhood": "bairro" } }
      custumer = subject.create_custumer(body)

      body = { "installment": { "customer_id": custumer["id"], "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "start_at": "2021-09-15", "total": "3", "description": "Hospedagem" } }
      expect(subject.create_installment(body)).to have_key("id")
    end

    it "invalid" do
      body = { "installment": { "customer_id": 0, "bank_billet_account_id": "1", "amount": "1.120,4", "cycle": "monthly", "start_at": "2021-09-15", "total": "3", "description": "Hospedagem" } }
      expect(subject.create_installment(body)).to have_key("errors")
    end
  end
end
