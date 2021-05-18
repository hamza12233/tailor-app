# frozen_string_literal: true

server '157.245.222.229', roles: %i[web app], primary: true

set :branch, :production
set :stage,  :production
