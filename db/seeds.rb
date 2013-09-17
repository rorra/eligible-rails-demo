# Seed payers
if Payer.count == 0
  Rake::Task['eligible:sync_payer_list'].invoke
end

if AdminUser.count == 0
  %w(rod@eligibleapi.com k@eligibleapi.com gg@eligibleapi.com).each do |email|
    puts "Creating Admin User #{email}"
    $stdout.flush

    au = AdminUser.new
    au.email = email
    au.password = 'eligible123'
    au.save!
  end
end