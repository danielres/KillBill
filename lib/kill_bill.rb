require 'bundler'
Bundler.require

require_relative '../models/invoice'
require_relative '../models/invoice_store'

class KillBill < Sinatra::Base

  def self.invoice_store= store
    @@invoice_store = store
  end

  def invoice_store
    @@invoice_store
  end

  configure :development do
    register Sinatra::Reloader
  end

  before do
    load_data
  end

  get '/' do
    invoice_store.entries.map do |e|
      "<li class='invoice'>#{e}</li>"
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0

  private

    def load_data
      @@invoice_store ||= InvoiceStore.new.tap{|s| s.new_invoice; s.new_invoice }
    end

end
