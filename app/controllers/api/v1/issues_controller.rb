require 'httparty'

class Api::V1::IssuesController < ApplicationController
  include HTTParty
  base_uri 'https://api.github.com/repos/xavzelada/repo_test/issues'

  def create
    activations = TomRadarActivation.find_by(status: "Pending")



    activations.each do | issue |
      self.class.post()

    end

  end
end
