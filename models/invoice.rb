class Invoice
  attr_reader :number, :entries, :hourly_rate, :vat

  def initialize number, options = {}
    @number       = number.to_i
    @hourly_rate  = options[:hourly_rate].to_f
    @vat          = options[:vat].to_f
    @@invoices  ||= []
    @@invoices   << self
    @entries    ||= []
  end

  def add_entry entry
    @entries  << entry
  end

  def total_hours
    @entries.map(&:hours).map(&:to_f).inject(:+)
  end

  def ex_vat_total
    ( total_hours * @hourly_rate ).round 2
  end


  def vat_total
    ( total_hours * @hourly_rate  * @vat / 100 ).round 2
  end

  def inc_vat_total
    ( ex_vat_total + vat_total ).round 2
  end

  def self.find number
    number = number.to_i
    @@invoices.select{ |i| i.number == number }.first
  end

  def self.all
    @@invoices
  end

end
