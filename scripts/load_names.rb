# Make bloomfilter and dump it for future use
#
# http://mbejda.github.io/
require 'csv'
require 'bloomfilter-rb'
require 'pry-byebug'

def load(type)
  bf = BloomFilter::Native.new(
    :size => 10_000_000,
    :hashes => 2,
    :seed => 1,
    :bucket => 3,
    :raise => false
  )

  Dir.glob("data/#{type}/*.csv").each do |file|
    CSV.foreach(file) do |line|
      name = line.first
      next if name == 'name'

      name.strip!
      name.downcase!
      bf.insert(name) unless bf.include?(name)
    end
  end

  dump = Marshal.dump(bf)

  File.write("data/#{type}.dump", dump)

  df = Marshal.load(File.read("data/#{type}.dump"))
end

load('surnames')
load('firstnames')
