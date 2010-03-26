#!/usr/bin/env ruby
$LOAD_PATH << File.dirname(__FILE__) + "/lib"

require "kokopelli"

require "kokopelli/http/request/base"

require "kokopelli/http/response/base"
require "kokopelli/http/response/failure"
require "kokopelli/http/response/invalid"
require "kokopelli/http/response/indeterminant"

require "kokopelli/exception/base"
require "kokopelli/exception/record_not_found"
require "kokopelli/exception/internal_error"

require "kokopelli/active_model/base"

require "kokopelli/principal/base"
require "kokopelli/principal/user"
require "kokopelli/principal/admin"
require "kokopelli/principal/host"
require "kokopelli/principal/guest"

require "kokopelli/sco/base"
require "kokopelli/sco/meeting"
require "kokopelli/sco/template"

require "kokopelli/utilities"

require "kokopelli/acts_as_kokopelli/shared_methods"
require "kokopelli/acts_as_kokopelli/guest"
require "kokopelli/acts_as_kokopelli/host"
require "kokopelli/acts_as_kokopelli/meeting"
require "kokopelli/acts_as_kokopelli/template"
