require "rails_helper"
Sidekiq::Testing.inline!

describe InvoiceChargeWorker, "#perform(invoice_id)" do

  before(:each) do
    stub_request(:post, "https://api.stripe.com/v1/customers").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_customer.json"))
    )
    stub_request(:get, "https://api.stripe.com/v1/customers/cus_4paKHGMWyPEkmv").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_customer.json"))
    )
    stub_request(:get, "https://api.stripe.com/v1/customers/cus_4paKHGMWyPEkmv/cards/card123").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_card.json"))
    )
    @invoice = create(:invoice, due_at: Time.now - 1.day, payment_method: create(:stripe_card))
    create(:single_line_item, invoice: @invoice)
    @invoice.reload
  end

  it "should update the invoice as paid if the charge is successful" do
    stub_request(:post, "https://api.stripe.com/v1/charges").to_return(
      body: File.read(File.join(Rails.root, "spec/web_mock/stripe_card_charge.json"))
    )
    expect(@invoice.paid?).to eq(false)

    InvoiceChargeWorker.perform_async(@invoice.id)
    @invoice.reload

    expect(@invoice.paid?).to eq(true)
  end

  it "should not update the invoice as paid if the charge fails" do
    stub_request(:post, "https://api.stripe.com/v1/charges").to_return(
      body:   File.read(File.join(Rails.root, "spec/web_mock/stripe_card_charge_fail.json")),
      status: 402
    )
    expect(@invoice.paid?).to eq(false)

    InvoiceChargeWorker.perform_async(@invoice.id)
    @invoice.reload

    expect(@invoice.paid?).to eq(false)
  end
end
