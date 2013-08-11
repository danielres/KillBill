Before do
  @invoice_store = InvoiceStore.new
  Capybara.app.invoice_store = @invoice_store
end

After do
  @invoice_store.reset
end
