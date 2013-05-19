require 'libusb'
require 'csv'

class USB

  def initialize
    usb = LIBUSB::Context.new
    @devices = usb.devices
  end

  def load_vendors
    @vendors = Hash.new
    CSV.foreach("./ids.csv") do |line|
     @vendors[line[0]] = line[1]
    end
  end

  def show_ids
    @devices.each do |dev|
      puts "%04x:%04x %s" % [dev.idVendor, dev.idProduct, lookup_manu("%04x" % dev.idVendor)]
    end
  end

  def lookup_manu vendor_id
    @vendors[vendor_id]
  end

end

my_usb = USB.new
my_usb.load_vendors
my_usb.show_ids

