require 'rake'
namespace :squidtree do
  task :import  => :environment do
    Post.all.each do |item|
      item.destroy
    end
    User.all.each do |item|
      item.destroy
    end
    Link.all.each do |item|
      item.destroy
    end
    
    ArUser.find(:all).each do |ar_user|
      user = User.new
      
      user.first_name = ar_user.first_name
      user.last_name = ar_user.last_name
      user.alias = ar_user.username
      
      user.save
      
      ar_user.links.each do |ar_link|
        link = Link.new
        
        link.url = ar_link.url
        link.title = ar_link.title
        link.comment = ar_link.comment
        link.user = user
        
        link.save
      end
      
      ar_user.posts.each do |ar_post|
        post = Post.new
        
        post.slug = ar_post.url
        post.title = ar_post.title
        post.content = ar_post.content
        post.user = user
        post.created_at = ar_post.created_at
        
        ar_post.tags.each do |ar_tag|
          post.tags << ar_tag.title
        end
        
        ar_post.comments.each do |ar_comment|
          comment = Comment.new

          comment.content = ar_comment.content
          comment.user = user
          comment.created_at = ar_comment.created_at
          post.comments << comment
          
          puts comment.inspect
        end
        
        post.save
      end
    end
  end
end