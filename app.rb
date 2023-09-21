require "sinatra"
require "sinatra/reloader"
require "net/http"
require "json"

get("/") do
  url = URI("https://api.exchangerate.host/symbols")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("symbols")
  erb(:pairs)
end

get("/:from") do
  @curr= params.fetch("from")
  url = URI("https://api.exchangerate.host/symbols")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("symbols")
  erb(:convert_from)
end

get("/:from/:to") do
  @curr1 = params.fetch("from")
  @curr2 = params.fetch("to")
  url = URI("https://api.exchangerate.host/convert?from=#{@curr1}&to=#{@curr2}")
  raw_data = Net::HTTP.get(url)
  parsed_data = JSON.parse(raw_data)
  @hash = parsed_data.fetch("info")
  @value = @hash.fetch("rate")
  erb(:convert_to)
end
