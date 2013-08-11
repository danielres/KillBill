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
    output << invoice.entries.map{ |e| "<li class='activity'>#{e.name}: #{e.hours}h</li>" }.join
    output << "</div>"
  end


  private

    def invoice_store
      @@invoice_store ||= load_invoice_store
    end

    def load_invoice_store
      InvoiceStore.new.tap do |s|
        s.new_invoice.add_entry( OpenStruct.new( name: 'Brogramming', hours: 10) )
        s.new_invoice
      end
    end

end
