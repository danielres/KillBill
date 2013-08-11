require_relative '../spec_helper'
require_relative '../../models/invoice_exhibit'

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


end