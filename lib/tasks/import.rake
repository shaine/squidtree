require 'rake'
namespace :squidtree do
  task :import  => :environment do
    ArUser.find(:all).each do |ar_user|
      user = User.new
      
      puts ar_user.first_name
    end
  end
end