namespace :squidtree do
  task :import do
    user = ArUser.find(1)
    puts user.inspect
  end
end