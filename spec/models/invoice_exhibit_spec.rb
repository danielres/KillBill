require_relative '../spec_helper'
require_relative '../../models/invoice_exhibit'
require 'capybara'

describe InvoiceExhibit do

  let( :invoice ){ instance_double "Invoice" }
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
      invoice.should_receive( :number        ).and_return 2013001
      invoice.should_receive( :hourly_rate   ).and_return 50
      invoice.should_receive( :vat           ).and_return 21
      invoice.should_receive( :entries       ).and_return [ stub( name: 'Brogramming', hours: 3 ), stub( name: 'Drawing', hours: 5 ) ]
      invoice.should_receive( :ex_vat_total  ).and_return 1000
      invoice.should_receive( :vat_total     ).and_return 210
      invoice.should_receive( :inc_vat_total ).and_return 1210
      invoice.should_receive( :emit_date     ).and_return Time.now
      html = Capybara.string exhibit.to_html
      expect( html ).to have_css '.invoice'
      expect( html ).to have_css '.activity', count: 2
      expect( html.all('.activity').first ).to have_content 'Brogramming'
      expect( html.all('.activity').first ).to have_content '3h'
      expect( html.all('.activity').last  ).to have_content 'Drawing'
      expect( html.all('.activity').last  ).to have_content '5h'
      expect( html ).to have_content '21%'
      expect( html ).to have_content '€1000'
      expect( html ).to have_content '€210'
      expect( html ).to have_content '€1210'
    end
  end


end