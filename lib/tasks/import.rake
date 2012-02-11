require 'rake'
namespace :squidtree do
  desc "Import Squidtree from MySQL database to MongoDB"
  task :import  => :environment do
    Post.collection.remove
    User.collection.remove
    Link.collection.remove
    SiteActivity.collection.remove
    
    users = []
    
    ArUser.find(:all).each do |ar_user|
      user = User.new
      
      user.first_name = ar_user.first_name
      user.last_name = ar_user.last_name
      user.alias = ar_user.username
      
      user.save
      
      users[ar_user.id] = user
      
      puts user.slug
    end
      
    ArLink.find(:all).each do |ar_link|
      link = Link.new
      
      link.url = ar_link.url
      link.title = ar_link.title
      link.comment = ar_link.comment
      link.user = users[ar_link.user_id]
      link.created_at = ar_link.created_at
      
      link.save
    end
      
    ArPost.find(:all).each do |ar_post|
      post = Post.new
      
      post.slug = ar_post.url
      post.title = ar_post.title
      post.content = ar_post.content.gsub("/images/posts", "/assets/posts").gsub("/images/smilies", "/assets/smilies")
      post.user = users[ar_post.user_id]
      post.created_at = ar_post.created_at
      
      ar_post.tags.each do |ar_tag|
        post.tags << ar_tag.title
      end
      
      ar_post.comments.each do |ar_comment|
        comment = Comment.new

        comment.content = ar_comment.content.gsub("/images/posts", "/assets/posts").gsub("/images/smilies", "/assets/smilies")
        comment.user = users[ar_comment.user_id]
        comment.created_at = ar_comment.created_at
        
        site_activity = SiteActivity.new
        site_activity.user = users[ar_comment.user_id]
        site_activity.created_at = comment.created_at
        comment.site_activities << site_activity
        
        post.comments << comment
      end
      
      post.save
      
      puts post.slug
    end
  end
end
