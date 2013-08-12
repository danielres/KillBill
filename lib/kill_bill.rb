require 'bundler'
Bundler.require

require_relative '../models/invoice'
require_relative '../models/invoice_store'
require_relative '../models/invoice_exhibit'


class KillBill < Sinatra::Base
  set :root, [ File.dirname(__FILE__), '/..'].join
  def self.invoice_store= store
    @@invoice_store = store
  end


  get '/' do
    invoices = invoice_store.entries.map{ |e| InvoiceExhibit.new( e ) }
    haml :index, locals: { invoices: invoices }, layout: false
  end

  get '/:invoice_number' do
    invoice = invoice_store.find params[:invoice_number]
    InvoiceExhibit.new( invoice ).to_html
  end


  private

    def invoice_store
      @@invoice_store ||= load_invoice_store_with_contents
    end

    def load_invoice_store_with_contents
      InvoiceStore.new.tap do |s|
        s.new_invoice( 123, vat: 21, hourly_rate: 56 ).tap do |i|
          i.add_entry( OpenStruct.new( name: 'Brogramming', hours: 10  ) )
          i.add_entry( OpenStruct.new( name: 'Laundry',     hours: 5.2 ) )
        end
        s.new_invoice
      end
    end

end
