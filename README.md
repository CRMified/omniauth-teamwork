# omniauth-teamwork

[OmniAuth](https://github.com/intridea/omniauth) Strategy for [teamwork.com](teamwork.com).

## Basic Usage

```ruby
require "sinatra"
require "omniauth"
require "omniauth-teamwork"

class MyApplication < Sinatra::Base
  use Rack::Session
  use OmniAuth::Builder do
    provider :teamwork, ENV['TIMELYAPP_KEY'], ENV['TIMELYAPP_SECRET']
  end
end
```


## Resources

* [Documentation: This document provides a full list of all Timely APIs currently available](https://dev.teamwork.com/)
