module Lita
  module Handlers
    class AuthCode < Handler
      namespace "authtoken"

      route(/^authme$/i, command: true) do |response|
        pin = get_pin
        redis.set(pin, response.user.id)
        response.reply(pin)
      end

      def get_pin
        pin = generate_pin
        check = redis.get(pin)

        if check
          get_pin
        else
          pin
        end
      end

      def generate_pin
        rand(100000..999999).to_s
      end

      Lita.register_handler(self)
    end
  end
end
