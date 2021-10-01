require "http"
require "json"

class Api::V1::IssuesController < ApplicationController
  @base_uri = 'https://api.github.com/repos/xavzelada/repo_test/issues'

  def create
    activations = TomRadarActivation.find_by(status: "Pending")



    TomRadarActivation.where(status: "Pending").each do | issue |
      puts issue.id
      response = HTTP[:accept => "application/vnd.github.v3+json",:Authorization => "token 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" ].post('https://api.github.com/repos/xavzelada/repo_test/issues', :json => { :title => issue.issuetitle, :body => issue.issuebody })
      puts JSON.pretty_generate( response)
      issue.status = "Success"
      issue.save
      #
      puts response
    end

  end
end
