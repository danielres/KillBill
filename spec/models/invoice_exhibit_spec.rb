require_relative '../spec_helper'
require_relative '../../models/invoice_exhibit'
require 'capybara'
require 'ostruct'

describe InvoiceExhibit do

  let( :invoice ){ instance_double "Invoice"  }
  let( :exhibit ){ InvoiceExhibit.new invoice }

  describe "#new" do
    it "creates an invoice exhibit, provided an invoice object" do
      expect( InvoiceExhibit.new invoice ).to be_kind_of InvoiceExhibit
    end
  end

  describe "#total_hours" do
    it "delegates total_hours to the object" do
      invoice.should_receive( :total_hours ).and_return 5.2
      expect( exhibit.total_hours ).to eq 5.2
    end
  end

  describe "#to_html" do
    it "renders the invoice as html with its contents" do
      jack_infos   = { name:  "Jack's name"  , address:      "Jack's address"    , phone: "Jack's phone",
                       email: "Jack's email" , vat_number:   "Jack's vat_number" , iban: "Jack's iban",
                       bic:   "Jack's bic"   , bank_address: "Jack's bank address" }
      client_infos = { first_name:   "David"      , last_name: "Wong",
                       company_name: "ClientCorp" , address:   "David's address" }
      jack   = OpenStruct.new jack_infos
      client = OpenStruct.new client_infos

      invoice.should_receive( :number        ).and_return 2013001
      invoice.should_receive( :hourly_rate   ).and_return 50
      invoice.should_receive( :vat           ).and_return 21
      invoice.should_receive( :entries       ).and_return [ stub( 'entry1', name: 'Brogramming', hours: 3, desc: '' ), stub( 'entry2', name: 'Drawing', hours: 5, desc: '' ) ]
      invoice.should_receive( :ex_vat_total  ).and_return 1000
      invoice.should_receive( :vat_total     ).and_return 210
      invoice.should_receive( :inc_vat_total ).and_return 1210
      invoice.should_receive( :emit_date     ).and_return Time.parse("2013-08-05")
      invoice.should_receive( :due_date      ).and_return Time.parse("2013-09-04")
      invoice.should_receive( :owner         ).and_return jack
      invoice.should_receive( :client        ).and_return client
      html = Capybara.string exhibit.to_html
      expect( html ).to have_css '.invoice'
      expect( html ).to have_css '.activity', count: 2
      expect( html.all('.activity').first ).to have_content 'Brogramming'
      expect( html.all('.activity').first ).to have_content '3h'
      expect( html.all('.activity').last  ).to have_content 'Drawing'
      expect( html.all('.activity').last  ).to have_content '5h'
      expect( html ).to have_content '2013-08-05'
      expect( html ).to have_content '2013-09-04'
      expect( html ).to have_content '21%'
      expect( html ).to have_content '€1000'
      expect( html ).to have_content '€210'
      expect( html ).to have_content '€1210'
      jack_infos.values.each  { |jack_info|   expect( html ).to have_content jack_info   }
      client_infos.values.each{ |client_info| expect( html ).to have_content client_info }
    end

  end


end