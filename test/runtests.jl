import Requests: URI, text, statuscode
using Base.Test

resp1 = Requests.get(URI("http://localhost:5000/"))
cookies = resp1.cookies
key = first(keys(resp1.cookies))
cookie = cookies[key]
@test cookie.name == key

token = match(r"value=\"(.*)\"", text(resp1))[1]
@test !isempty(token)

#Dict("_hello_phoenix_key"=>Cookie(_hello_phoenix_key, SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYRXRhdHFJQW9uaDhkRFEvNTFodk5iQT09.rXEYQs9WKy8OISnrGksTUCN8dD8xlPKNFLqbVt5SsDY, 2 attributes))
#Dict("HttpOnly"=>"","path"=>"/")

resp5 = Requests.post(URI("http://localhost:5000/post"), cookies=resp1.cookies, data=Dict("_csrf_token"=>""))
@test 403 == statuscode(resp5)
@test isempty(resp5.cookies)

resp2 = Requests.post(URI("http://localhost:5000/post"), cookies=resp1.cookies, data=Dict("_csrf_token"=>token))
@test 200 == statuscode(resp2)
@test isempty(resp2.cookies)

resp3 = Requests.post(URI("http://localhost:5000/post"), cookies=resp1.cookies, data=Dict("_csrf_token"=>token))
@test isempty(resp2.cookies)
@test 200 == statuscode(resp3)
