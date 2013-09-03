class Invoice
  attr_reader :number, :entries

  def initialize number
    @number      = number
    @@invoices ||= []
    @@invoices  << self
  end

  def add_entry entry
    @entries ||= []
    @entries << entry
  end

  def total_hours
    @entries.map(&:hours).map(&:to_f).inject(:+)
  end

  def self.find number
    @@invoices.select{ |i| i.number == number }.first
  end

end
