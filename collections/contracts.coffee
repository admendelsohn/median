Backbone = require 'backbone'
sd = require("sharify").data
Contract = require '../models/contract.coffee'
_ = require 'underscore'

module.exports = class Contracts extends Backbone.Collection
  model: Contract

  url: -> "#{sd.KERNAL_API_URL}/contracts"

  relativeMarketCap: (contract) ->
    totalMarketCap = @reduce (memo, contract) ->
      (memo || 0) + Math.log(contract.getMarketCap())

    mc = (Math.log(contract.getMarketCap()) / totalMarketCap) or .01
    return (mc * 6) * 100
