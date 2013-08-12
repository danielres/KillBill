require 'haml'

class InvoiceExhibit < SimpleDelegator

  def initialize invoice
    @invoice = invoice
    __setobj__(invoice)
  end

  def hourly_rate
    format_price @invoice.hourly_rate
  end

  def ex_vat_total
    format_price @invoice.ex_vat_total
  end

  def vat_total
    format_price @invoice.vat_total
  end

  def inc_vat_total
    format_price @invoice.inc_vat_total
  end

  def to_html
    haml :invoice, number: number,
                emit_date: emit_date,
                 due_date: due_date,
                  entries: entries,
                      vat: vat,
              hourly_rate: hourly_rate,
             ex_vat_total: ex_vat_total,
                vat_total: vat_total,
            inc_vat_total: inc_vat_total
  end

  private

    def haml identifier, locals = {}, &block
      Haml::Engine.new( File.read "views/#{identifier}.html.haml" ).render( Object.new, locals ) do
        block.call if block
      end
    end

    def format_price price
      '%.2f' % price
    end

end