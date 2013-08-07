class Invoice
  attr_reader :number, :entries, :hourly_rate, :vat

  def initialize number, options = {}
    @number      = number
    @hourly_rate = options[:hourly_rate].to_f
    @vat = options[:vat]
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

  def ex_vat_total
    ( total_hours * @hourly_rate ).round 2
  end

  def self.find number
    @@invoices.select{ |i| i.number == number }.first
  end

end
