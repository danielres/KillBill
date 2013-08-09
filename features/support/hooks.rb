Before do
  @invoice_store = InvoiceStore.new
end

After do
  @invoice_store.reset
end
