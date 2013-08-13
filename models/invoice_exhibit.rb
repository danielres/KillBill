require 'haml'

class InvoiceExhibit < SimpleDelegator


  def hourly_rate   ; format_price super end
  def ex_vat_total  ; format_price super end
  def vat_total     ; format_price super end
  def inc_vat_total ; format_price super end

  def emit_date ; format_date super end
  def due_date  ; format_date super end

  def owner ; format_person super end

  def to_html
    haml :invoice, number: number,
                    owner: owner,
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

    def format_date date
      date.strftime "%F"
    end

    def format_person person
      [ person.name,       person.address,
        person.phone,      person.email,
        person.vat_number, person.iban,
        person.bic,        person.bank_address ].join '<br />'
    end

end