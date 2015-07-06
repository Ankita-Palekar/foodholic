use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == 'secret'
end