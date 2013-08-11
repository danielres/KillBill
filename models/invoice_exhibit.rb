class InvoiceExhibit < SimpleDelegator

  def initialize invoice
    @invoice = invoice
    __setobj__(invoice)
  end

  def to_html
    output = "<div class='invoice'>"
    output << "#{@invoice}"
    output << "<br />"
    output << "Activities:"
    output << @invoice.entries.map{ |e| "<li class='activity'>#{e.name}: #{e.hours}h</li>" }.join
    output << "<hr />"
    output << "Hourly rate: €#{@invoice.hourly_rate}"
    output << "<br />"
    output << "Total HT: €#{@invoice.ex_vat_total}"
    output << "<br />"
    output << "+TVA #{@invoice.vat}%: €#{@invoice.vat_total}"
    output << "<br />"
    output << "Total TTC: €#{@invoice.inc_vat_total}"
    output << "<br />"
    output << "</div>"
  end

end