require 'bundler'
Bundler.require

require_relative '../models/invoice'
require_relative '../models/invoice_store'
require_relative '../models/invoice_exhibit'


class KillBill < Sinatra::Base
  set :root, [ File.dirname(__FILE__), '/..'].join

  def initialize
    super
    @@invoice_store ||= load_invoice_store_with_contents
  end

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
      @@invoice_store
    end

    def load_invoice_store_with_contents
      require_relative 'data'
      STORE
    end

end
