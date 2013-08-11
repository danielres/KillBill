require 'bundler'
Bundler.require

require_relative '../models/invoice'
require_relative '../models/invoice_store'


class KillBill < Sinatra::Base

  configure( :development ){ register Sinatra::Reloader }

  def self.invoice_store= store
    @@invoice_store = store
  end


  get '/' do
    invoice_store.entries.map do |e|
      "<li class='invoice'>#{e}</li>"
    end
  end

  get '/:invoice_number' do
    invoice = invoice_store.find params[:invoice_number]
    output = "<div class='invoice'>"
    output << "#{invoice}"
    output << "<br />"
    output << "Activities:"
    output << invoice.entries.map{ |e| "<li class='activity'>#{e.name}: #{e.hours}h</li>" }.join
    output << "<hr />"
    output << "Hourly rate: €#{invoice.hourly_rate}"
    output << "<br />"
    output << "Total HT: €#{invoice.ex_vat_total}"
    output << "<br />"
    output << "+TVA #{invoice.vat}%: €#{invoice.vat_total}"
    output << "<br />"
    output << "Total TTC: €#{invoice.inc_vat_total}"
    output << "<br />"
    output << "</div>"
  end


  private

    def invoice_store
      @@invoice_store ||= load_invoice_store
    end

    def load_invoice_store
      InvoiceStore.new.tap do |s|
        s.new_invoice( 123, vat: 21, hourly_rate: 56 ).tap do |i|
          i.add_entry( OpenStruct.new( name: 'Brogramming', hours: 10  ) )
          i.add_entry( OpenStruct.new( name: 'Laundry',     hours: 5.2 ) )
        end
        s.new_invoice
      end
    end

end
