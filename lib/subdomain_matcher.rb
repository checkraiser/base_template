class SubdomainMatcher
  def self.matches?(request)
  	if request.subdomain.present?
	  subdomains = Account.pluck(:subdomain)
	  subdomains.include? request.subdomain
	end
  end
end