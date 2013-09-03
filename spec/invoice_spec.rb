require_relative '../models/invoice'

describe Invoice do
  describe "#new" do
    let(:invoice){ Invoice.new 123 }
    it "creates an invoice with a number" do
      invoice.number.should == 123
    end
  end

  describe "#find" do
    before(:all) do
      @invoice1 = Invoice.new 1
      @invoice2 = Invoice.new 2
    end
    it "retrieves a specific invoice by its number" do
      Invoice.find(1).should eq @invoice1
      Invoice.find(2).should eq @invoice2
    end
  end

  describe "#add_entry, #entries" do
    let( :invoice ){ Invoice.new 567 }
    let( :entry1  ){ Object.new      }
    let( :entry2  ){ Object.new      }
    it "keeps a list of the invoice entries" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      invoice.entries.should =~ [ entry1, entry2 ]
    end
  end

  describe "#total_hours" do
    let( :invoice ){ Invoice.new 123 }
    let( :entry1  ){ Object.new.tap{ |o| o.stub( hours: 3   ) } }
    let( :entry2  ){ Object.new.tap{ |o| o.stub( hours: 5.1 ) } }
    it "outputs the total hours for the invoice with entries" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      invoice.total_hours.should == 8.1
    end

  end

end