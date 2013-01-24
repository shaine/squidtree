require 'rake'

$terminal = %x(echo $TERM).strip!
$unsafe_methods_pattern = /(_id=|_ids=|_type=|admin=)$/

module Colors
  def colorize(text, color_code)
    "\[\033[0;#{color_code}m\]#{text}\033[0m"
  end

  {
    :black    => 30,
    :red      => 31,
    :green    => 32,
    :yellow   => 33,
    :blue     => 34,
    :magenta  => 35,
    :cyan     => 36,
    :white    => 37
  }.each do |key, color_code|
    define_method key do |text|
      colorize(text, color_code)
    end
  end
end

namespace :squidtree do
  desc "Import FB links"
  task :import_links => :environment do
    user = User.find_by_first_name("Shaine")
    link = nil
    File.open(Rails.root.join('lib/tasks/wall.html'), "r").each_line do |line|
      unless line == "\n"
        line = line.gsub(/\r?\n/, '')

        unless link
          link = Link.new
          link.user = user
        end

        # Actual link
        if /^http/.match(line)
          match = /^(.*)\|\|(.*)$/.match(line)
          if match
            link.url = match[1]
            link.title = match[2]
          end
        # Haven't reached link line yet (comment line)
        elsif link.url.nil? && link.comment.nil?
          link.comment = line
        # Date line
        else
          puts "else line: " + line
          # Don't run for invalid links
          unless link.url.nil?
            link.created_at = Time.parse(line)
          end
        end
      else
        if link
          if link.save
            green "Saved - #{link.title}"
          else
            red "Unsaved - #{link.url} - #{link.comment}"
          end

          link = nil
        end
      end
      next
    end
  end
end
