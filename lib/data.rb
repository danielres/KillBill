STORE = InvoiceStore.new.tap do |s|

  defaults = { vat: 21, hourly_rate: 56 }

  i1 = s.new_invoice 123, defaults
  i1.add_entry name: 'Brogramming', hours: 10
  i1.add_entry name: 'Laundry'    , hours: 5.2


  i2 = s.new_invoice defaults
  i2.add_entry name: 'Brogramming', hours: 66

end