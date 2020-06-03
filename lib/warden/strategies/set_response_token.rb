# frozen_string_literal: true

# set the response token on the response
class Warden::Strategies::SetResponseToken
  def initialize(app)
    @app = app
  end

  def call(env)
    res = @app.call(env)

    # res[0] is the status
    if res[0] < 300 && !skip_request(env)
      res[1]['Access-Token'] = env['warden'].user.token
    end
    res
  end

  private

  # if its the login route dont return the token in the header
  def skip_request(env)
    env['REQUEST_PATH'] =~ %r{/login$}
  end
end
