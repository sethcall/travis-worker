module Travis
  module Worker
    module Job
      module Helpers
        # Carries out task of cloning or synchronizing Git repositories and setting up the stage
        # for build to run on (for example, installing dependencies using Bundler, cleanin up build
        # artifacts and so on).
        #
        # ### Key methods
        #
        # * #checkout
        #
        # @see Travis::Job::Base
        class Repository

          attr_reader :slug

          attr_accessor :shell

          # @api public
          def initialize(slug)
            @slug   = slug
          end

          # @api public
          def checkout(commit = nil)
            status = if exists?
              fetch
            else
              clone
            end
            status && checkout_commit(commit)
          end

          # @api plugin
          def raw_url
            "https://raw.github.com/#{slug}"
          end

          # @api plugin
          def exists?
            shell.execute("test -d #{slug}", :echo => false)
          end

          #
          # Implementation
          #

          protected

            # @api plugin
            def clone
              shell.execute('export GIT_ASKPASS=echo', :echo => false) # this makes git interactive auth fail
              shell.execute("git clone --depth=1000 --quiet #{source} #{slug}") &&
                change_directory
            end

            # @api plugin
            def fetch
              change_directory
              shell.execute('git clean -fdx') &&
                shell.execute('git fetch')
            end

            # @api plugin
            def source
              "git://github.com/#{slug}.git"
            end

            def change_directory
              shell.execute("cd #{slug}", :echo => false)
            end

            def checkout_commit(commit)
              commit ? shell.execute("git checkout -qf #{commit}") : true
            end
        end # Repository
      end
    end # Job
  end # Worker
end # Travis
