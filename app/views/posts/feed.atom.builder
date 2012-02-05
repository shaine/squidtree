atom_feed :language => 'en-US' do |feed|
  feed.title @title
  feed.updated @updated

  @posts.each do |item|
    next if item.updated_at.blank?

    # the strftime is needed to work with Google Reader.
    updated_at = item.is_old?? item.created_at : item.updated_at

    feed.entry(item, :url => blog_url(item.slug), :updated=>updated_at) do |entry|
      entry.title strip_tags(item.title)
      entry.content item.content, :type => 'html'

      entry.updated(updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")) 

      entry.author do |author|
        author.name item.user.name rescue "Unknown"
      end
    end
  end
end
