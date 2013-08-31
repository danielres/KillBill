require 'haml'

$LOAD_PATH.unshift 'models'
require 'text_evaluator'

class InvoiceExhibit < SimpleDelegator


  def hourly_rate   ; format_price super end
  def ex_vat_total  ; format_price super end
  def vat_total     ; format_price super end
  def inc_vat_total ; format_price super end


  def emit_date ; format_date super end
  def due_date  ; format_date super end

  def owner   ; format_person  super end
  def client  ; format_client  super end
  def entries ; format_entries super end

  def to_html
    haml :invoice, number: number,
                    owner: owner,
                   client: client,
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
        person.bic,        person.bank_address ].compact.join '<br />'
    end
    def format_client client
      [ client.first_name,
        client.last_name,
        client.company_name,
        client.address].compact.join '<br />'
    end
    def format_entries entries
      entries.map{ |e| format_entry e }
    end
    def format_entry entry
      e        = TextEvaluator.new
      new_desc = e.evaluate entry.desc, context: __getobj__, entry: entry, separator: '<br />'
      entry.define_singleton_method(:desc){ new_desc }
      entry
    end

end