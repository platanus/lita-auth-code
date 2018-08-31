require "lita"

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require "lita/handlers/auth_code"
require "lita/extensions/auth_code_check"
require "lita/handlers/http_route"

Lita::Handlers::AuthCode.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
