require "sinatra/base"

module LinkBlocker
  def block_links_from(host)
    before {
      halt 403, "Go Away!" if request.referer.match(host)
    }
  end
end

class App < Sinatra::Base
  register LinkBlocker
  block_links_from 'digg.com'

  get "/" do
    "Hello World"
  end
end

class User < Sinatra::Base
  def defer(&block)
    def block.each; yield call; end
    block
  end

  get "/:user" do |user|
    last_modified(User.first(:name => user, :fields => [:updated_at]))
    defer {
      erb :profile, :user => User.first(:name => user)
    }
  end
end
