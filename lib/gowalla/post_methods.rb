module Gowalla
  module PostMethods

    # Create a flag on a particular spot (Reports a problem to Gowalla)
    # WARNING: This method uses calls not officially supported by Gowalla.
    #
    # @param [String] flag_type Type of flag to create: invalid,duplicate,mislocated,venue_closed,inaccurate_information
    # @param [String] description Description of the problem
    def create_spot_flag(spot_id, flag_type, description)
      response = connection.post do |req|
        req.url "/spots/#{spot_id}/flags/#{flag_type}"
        req.body = {:description => description}
      end
      response.body
    end

    # Check in at a spot
    #
    # @option details [Integer] :spot_id Spot ID
    # @option details [Float] :lat Latitude of spot
    # @option details [Float] :lng Longitude of spot
    # @option details [String] :comment Checkin comment
    # @option details [Boolean] :post_to_twitter Post Checkin to Twitter
    # @option details [Boolean] :post_to_facebook Post Checkin to Facebook
    def create_checkin(details={})
      checkin_path = "/checkins"
      checkin_path += "/test" if Gowalla.test_mode?
      response = connection.post do |req|
        req.url checkin_path
        req.body = details
      end
      response.body
    end


  end
end