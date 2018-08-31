module Lita
  module Handlers
    class AuthCode < Handler
      route(/^authme$/i, command: true) do |response|
        pin = rand(100000..999999).to_s
        redis.set(response.user.id, pin)
        response.reply(pin)
      end

      Lita.register_handler(self)
    end
  end
end
