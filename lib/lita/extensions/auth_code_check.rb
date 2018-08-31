require 'pry'

module Lita
  module Extensions
    class AuthCodeCheck
      def self.call(payload)
        route = payload[:request]
        response = payload[:response]
        check_auth = route.env["HTTP_X_AUTH"]
        if check_auth
          user_id = named_redis.get(check_auth)
          route.update_param(:user_id, user_id)
        end
      end

      def self.named_redis
        @named_redis = Redis::Namespace.new(
          "lita:handlers:authtoken",
          redis: Redis.new
        )
      end
      Lita.register_hook(:trigger_http, self)
    end
  end
end
