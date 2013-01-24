Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, (ENV['FACEBOOK_KEY'] || '512085622148416'), (ENV['FACEBOOK_SECRET'] || '357bb7cf614657288ae6b0c603e34922')
end

OmniAuth.config.on_failure = Proc.new do |env|
  new_path = "/auth/failure"
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end
