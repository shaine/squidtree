Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
end

OmniAuth.config.on_failure = Proc.new do |env|
  new_path = "/auth/failure"
  [302, {'Location' => new_path, 'Content-Type'=> 'text/html'}, []]
end
