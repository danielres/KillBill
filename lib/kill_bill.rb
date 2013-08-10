require 'bundler'
Bundler.require

require_relative '../models/invoice'
require_relative '../models/invoice_store'

class KillBill < Sinatra::Base

get '/' do
  store = InvoiceStore.new
  store.new_invoice(2013001)
  store.new_invoice
  "Time to KillBill !!" + store.entries.count.to_s
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
