require 'rake'

$terminal = %x(echo $TERM).strip!
$unsafe_methods_pattern = /(_id=|_ids=|_type=|admin=)$/

def puts_in_color(text, options = {})
  if $terminal == 'xterm-color'
    case options[:color]
    when :red
      puts "\033[31m#{text}\033[0m"
    when :green
      puts "\033[32m#{text}\033[0m"
    else
      puts text
    end
  else
    puts text
  end
end

def green(text)
  puts_in_color text, :color => :green
end

def red(text)
  puts_in_color text, :color => :red
end

namespace :squidtree do
  desc "Cleanup Squidtree database content"
  task :cleanup => :environment do
    posts = Post.all :order => :created_at.asc
    posts.each do |post|
      post.content = post.content.gsub "http://hatch.fadelight.com/assets", "/assets"
      post.content = post.content.gsub "src=\"images/", "src=\"/assets/"
      post.content = post.content.gsub "/assets/yellowstone", "/assets/posts"
      post.content = post.content.gsub "smilies/sad.gif", "smilies/Unhappy.png"
      post.content = post.content.gsub "smilies/happy.gif", "smilies/Grinning.png"
      post.content = post.content.gsub "smilies/wink.gif", "smilies/Winking.png"
      post.content = post.content.gsub "smilies/smile.gif", "smilies/Smiling.png"
      post.content = post.content.gsub "smilies/openmouth.gif", "smilies/Gasping.png"
      post.content = post.content.gsub "smilies/huh.gif", "smilies/Blushing.png"
      post.content = post.content.gsub "smilies/glasses.gif", "smilies/Sunglasses.png"

      if post.changed?
        green "#{post.title} - Updated"
        post.save
      else
        red "#{post.title} - Not Updated"
      end
    end

    post = Post.find("4eee94096c25de3a8000040a")
    post.content = post.content.gsub "<em>", "&lt;em&gt;"

    if post.changed?
      green "#{post.title} - Updated"
      post.save
    else
      red "#{post.title} - Not Updated"
    end
  end
end
