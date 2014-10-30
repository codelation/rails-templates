class InvoiceChargeWorker
  include Sidekiq::Worker

  def perform(invoice_id)
    @invoice = Invoice.find_by_id(invoice_id)
    return unless @invoice

    @invoice.finalize!
  end

end
