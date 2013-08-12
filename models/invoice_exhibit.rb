require 'haml'

class InvoiceExhibit < SimpleDelegator

  def initialize invoice
    @invoice = invoice
    __setobj__(invoice)
  end

  def to_html
    haml :invoice, number: @invoice.number,
                emit_date: @invoice.emit_date,
                  entries: @invoice.entries,
                      vat: @invoice.vat,
              hourly_rate: '%.2f' % @invoice.hourly_rate,
             ex_vat_total: '%.2f' % @invoice.ex_vat_total,
                vat_total: '%.2f' % @invoice.vat_total,
            inc_vat_total: '%.2f' % @invoice.inc_vat_total
  end

  private

    def haml identifier, locals = {}, &block
      Haml::Engine.new( File.read "views/#{identifier}.html.haml" ).render( Object.new, locals ) do
        block.call if block
      end
    end

end