require 'lively/sse'

class UsersController < ApplicationController
  include ActionController::Live

  def live
    # SSE expects the `text/event-stream` content type
    response.headers['Content-Type'] = 'text/event-stream'

    sse = Lively::SSE.new(response.stream)

    ticker = Thread.new { loop { sse.write 0; sleep 5 } }

    sender = Thread.new do
      $redis.subscribe('user.create', 'user.game.invite') do |on|
        on.message do |event, data|
          sse.write(data, event: event.to_s)
        end
      end
    end

    ticker.join
    sender.join

    render nothing: true
  rescue IOError => ex
    Rails.logger.debug ex
    # When the client disconnects, we'll get an IOError on write
    @_current_user.is_offline! if @_current_user
  ensure
    Thread.kill(ticker) if ticker
    Thread.kill(sender) if sender

    sse.close
  end

end
