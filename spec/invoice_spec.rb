require_relative '../models/invoice'

describe Invoice do

  after :each do
    Invoice.reset_all
    Invoice.all.should be_empty
  end

  describe "#new" do
    it "creates an invoice with a number attribute" do
      invoice =  Invoice.new 123
      expect( invoice.number ).to eq 123
    end
    it "refuses to create an invoice with an already taken number" do
      Invoice.new 123
      expect{ Invoice.new 123 }.to raise_error StandardError
    end
    describe "with parameters" do
      invoice = Invoice.new 567, vat: 21, hourly_rate: 56
      it "accepts a value for vat" do
        expect( invoice.vat ).to eq 21
      end
      it "accepts a value for hourly_rate" do
        expect( invoice.hourly_rate ).to eq 56
      end
    end
  end

  describe "#find" do
    let!(:invoice1){ Invoice.new 1 }
    let!(:invoice2){ Invoice.new 2 }
    it "retrieves a unique invoice by its number" do
      expect( Invoice.find 1 ).to be invoice1
      expect( Invoice.find 2 ).to be invoice2
    end
    it "returns nil if none found" do
      expect( Invoice.find 3 ).to be_nil
    end
  end

  describe "#all" do
    let!(:invoice1){ Invoice.new 1 }
    let!(:invoice2){ Invoice.new 2 }
    it "returns a list with all invoices" do
      expect( Invoice.all ).to match_array [ invoice1, invoice2 ]
    end
    it "returns an empty list if none found" do
      Invoice.reset_all
      expect( Invoice.all ).to eq []
    end
  end

  describe "#add_entry, #entries" do
    let( :invoice ){ Invoice.new 567 }
    let( :entry1  ){ stub }
    let( :entry2  ){ stub }
    it "keeps a list of the invoice entries" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.entries).to match_array [ entry1, entry2 ]
    end
  end

  describe "#total_hours" do
    let( :invoice ){ Invoice.new 123 }
    let( :entry1  ){ stub hours: 3   }
    let( :entry2  ){ stub hours: 5.1 }
    it "returns the total hours for the invoice with entries" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.total_hours ).to eq 8.1
    end
  end

  describe "#ex_vat_total" do
    let( :invoice ){ Invoice.new 123, vat: 21, hourly_rate: 56 }
    let( :entry1  ){ stub hours: 3   }
    let( :entry2  ){ stub hours: 5.1 }
    it "returns the total money charged for that invoice, without taxes" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.ex_vat_total ).to eq 453.60
    end
  end

  describe "#vat_total" do
    let( :invoice ){ Invoice.new 123, vat: 21, hourly_rate: 56 }
    let( :entry1  ){ stub hours: 3   }
    let( :entry2  ){ stub hours: 5.1 }
    it "returns the VAT amount for that invoice, rounded to the second decimal" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.vat_total ).to eq ( 453.60  * 21 / 100 ).round 2
    end
  end

  describe "#inc_vat_total" do
    let( :invoice ){ Invoice.new 123, vat: 21, hourly_rate: 56 }
    let( :entry1  ){ stub hours: 3   }
    let( :entry2  ){ stub hours: 5.1 }
    it "returns the total money charged for that invoice, with taxes" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.inc_vat_total ).to eq ( 453.60 + ( 453.60 * 21 / 100 ) ).round 2 # 548.86
    end
  end
  describe "#reset_all" do
    let!( :invoice ){ Invoice.new 123 }
    it "resets the list of invoices" do
      Invoice.all.should_not be_empty
      Invoice.reset_all
      Invoice.all.should be_empty
    end
  end
end