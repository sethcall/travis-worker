source :rubygems
gem 'resque',              '~> 1.17.0'
gem 'resque-meta',         '~> 1.0.3'
gem 'em-http-request',     '~> 0.3.0'
gem 'vagrant'
gem 'sahara'
gem 'net-ssh'
gem 'net-ssh-shell'
gem 'capture_stdout'

group :test do
  gem 'mocha'
  gem 'test_declarative'
  # gem 'web-socket-ruby'
  # gem 'fakeredis'
  # gem 'fakeweb'

  platforms :ruby_18 do
    gem 'minitest'
    gem 'minitest_tu_shim'
  end

  platforms :mri_18 do
    gem 'ruby-debug'
  end

  platforms :mri_19 do
    gem 'ruby-debug19'
  end
end

