class InvoiceExhibit < SimpleDelegator

  def initialize invoice
    @invoice = invoice
    __setobj__(invoice)
  end

  def to_html
    @entries = @invoice.entries.map{ |e| "<li class='activity'>#{e.name}: #{e.hours}h</li>" }.join
    "<div class='invoice'>
      #{@invoice}                                       <br />

      Activities:
      #{@entries}

      <hr />

      Hourly rate:           €#{@invoice.hourly_rate}   <br />
      Total HT:              €#{@invoice.ex_vat_total}  <br />
      +TVA #{@invoice.vat}%: €#{@invoice.vat_total}     <br />
      Total TTC:             €#{@invoice.inc_vat_total} <br />

    </div>"
  end

end