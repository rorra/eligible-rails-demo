namespace :eligible do
  desc 'Syncs payer list'
  task sync_payer_list: :environment do
    require 'open-uri'

    source = "https://eligibleapi.com/resources/information-sources.json"
    puts "Fetching #{source}"
    $stdout.flush
    data = JSON.load(open(source).read)

    data.each do |row|
      puts "Processing #{row['payer_id']}"
      $stdout.flush

      payer = Payer.where(payer_id: row['payer_id']).first

      next if payer

      payer = Payer.new(payer_id: row['payer_id'])
      row['names'].each { |name| payer.payer_names.build(name: name) }
      payer.save!
    end
  end
end
