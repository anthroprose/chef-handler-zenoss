module ZaaS
  class ZenossJSONAPI < Chef::Handler

    def initialize(ip_addr, user, pass, protocol='https://', device='ChefDeploy', component='ChefHandler')
      @ip_addr = ip_addr
      @protocol = protocol
      @user = user
      @pass = pass
      @device = device
      @component = component
      @severity = 'Debug'
      @path = '/zport/dmd/evconsole_router'
    end

    def report
      
      require 'rubygems'
      require 'rest_client'
      require  'json'
 
      url = @protocol + @user + ':' + @pass + '@' + @ip_addr + @path
      
      if run_status.success?
        message = "Chef run complete on #{node.name} - " + run_status.elapsed_time.to_s + "s"
        @severity = "info"
      else
        message = "Chef run failed on #{node.name} - " + run_status.elapsed_time.to_s + "s - #{run_status.formatted_exception} " + Array(backtrace).join(" - ")
        @severity = "Critical"
      end
      
      jdata = { "action" => "EventsRouter", "method" => "add_event", "data"  => [{ "device" => @device, "summary" => message, "component" => @component, "severity" => @severity, "evclass" => "/Unknown", "evclasskey" => "" }], "tid" => 1 }.to_json
      response = RestClient.post url,  jdata, { :content_type => :json, :accept => :json, :verify_ssl => FALSE }

    end
  end
end