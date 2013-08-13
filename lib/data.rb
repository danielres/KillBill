owner = OpenStruct.new name: "Owner's name",
                    address: "Owner's address",
                      phone: "Owner's phone",
                      email: "Owner's email",
                 vat_number: "Owner's vat_number",
                       iban: "Owner's iban",
                        bic: "Owner's bic",
               bank_address: "Owner's bank address"

STORE = InvoiceStore.new( owner: owner ).tap do |s|

  defaults = { vat: 21, hourly_rate: 56 }

  i1 = s.new_invoice 123, defaults
  i1.add_entry name: 'Brogramming', hours: 10
  i1.add_entry name: 'Laundry'    , hours: 5.2


  i2 = s.new_invoice defaults
  i2.add_entry name: 'Brogramming', hours: 66

end