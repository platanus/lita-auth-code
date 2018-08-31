require "rack"

module Lita
  class HTTPCallback
    def call(env)
      request = Rack::Request.new(env)
      response = Rack::Response.new

      if request.head?
        response.status = 204
      else
        begin
          handler = @handler_class.new(env["lita.robot"])
          env["lita.robot"].hooks[:trigger_http].each { |hook| hook.call(response: response, request: request) }
          @callback.call(handler, request, response)
        rescue => e
          robot = env["lita.robot"]
          error_handler = robot.config.robot.error_handler

          if error_handler.arity == 2
            error_handler.call(e, rack_env: env, robot: robot)
          else
            error_handler.call(e)
          end

          raise
        end
      end

      response.finish
    end
  end
end
