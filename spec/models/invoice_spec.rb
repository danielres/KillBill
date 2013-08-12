require_relative '../spec_helper'
require_relative '../../models/invoice'
require 'time'

describe Invoice do

  describe "#new" do
    it "creates an invoice, with a number attribute" do
      invoice = Invoice.new 123
      expect( invoice.number ).to eq 123
    end
    it "accepts a client as option parameter" do
      client  = stub
      invoice = Invoice.new 123, client: client
      expect( invoice.client ).to be client
    end
    it "accepts an invoice store as option parameter" do
      store   = stub
      invoice = Invoice.new 123, store: store
      expect( invoice.store ).to be store
    end
    it "accepts an emit date as option parameter" do
      invoice = Invoice.new 123, emit_date: "2013/02/01"
      expect( invoice.emit_date ).to eq Time.parse("2013/02/01")
    end

    it "sets now as emit date if none passed" do
      invoice = Invoice.new 123
      # 1 second tolerance:
      expect( invoice.emit_date ).to be_within( 1 ).of( Time.now )
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

  describe "#total_hours" do
    let( :invoice ){ Invoice.new 123 }
    let( :entry1  ){ stub hours: 3   }
    let( :entry2  ){ stub hours: 5.1 }
    it "returns the total hours for the invoice with entries" do
      invoice.add_entry entry1
      invoice.add_entry entry2
      expect( invoice.total_hours ).to eq 8.1
    end
    it "returns 0 when no entries" do
      expect( invoice.total_hours ).to eq 0
    end
  end

  describe "#due_date" do
    let( :emit_date ){ Time.parse '2013-08-05' }
    let( :invoice   ){ Invoice.new 123 }
    it "returns a due date that is 30 days after the emit date" do
      invoice.stub emit_date: emit_date
      expect( invoice.due_date ).to eq Time.parse( '2013-09-04' )
    end
  end

  describe "#ex_vat_total" do
    let( :invoice ){ Invoice.new 123, hourly_rate: 56 }
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

end