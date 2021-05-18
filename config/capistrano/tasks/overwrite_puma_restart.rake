# frozen_string_literal: true

namespace :puma do
  Rake::Task[:restart].clear_actions
  desc 'Overwritten puma:restart task'
  task :restart do
    on roles(:app) do
      invoke 'puma:stop'
      invoke 'puma:start'
    end
  end
end
