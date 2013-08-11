class InvoiceExhibit < SimpleDelegator

  def initialize invoice
    @invoice = invoice
    __setobj__(invoice)
  end

end