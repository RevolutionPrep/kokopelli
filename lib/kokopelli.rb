raw_config = File.read(RAILS_ROOT + "/config/kokopelli_config.yml")
KOKOPELLI = YAML.load(raw_config)[RAILS_ENV].symbolize_keys

module Kokopelli

  def self.admin
    @admin ||= Principal::Admin.new(:login => KOKOPELLI[:login], :password => KOKOPELLI[:password])
    @admin.signin if @admin.stale? || KOKOPELLI[:force_admin_reload]
    @admin
  end

end