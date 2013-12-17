cache_cache
===========

CacheCache allow you to manage dynamically multiple groups of HTML5 manifests using rails cache.

# Installation #

`> gem install cache_cache`

# How to use #

`Rails::CacheCache.new do 
cache ActionController::Base.helpers.asset_path("application.css") 
cache ActionController::Base.helpers.asset_path("application.js")
network "*"
save
end`