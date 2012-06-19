module Locomotive
  class Routes
    def self.draw_into(routes)
      routes.instance_eval do
        namespace :locomotive, :module => 'locomotive' do
          namespace :api do

            resources :tokens, :only => [:create, :destroy]

            resources :theme_assets

            resources :content_assets

            resources :snippets

            resources :pages

            resources :content_types

            resources :content_entries, :path => 'content_types/:slug/entries'

            resources :sites

            resources :memberships

            resource  :current_site, :controller => 'current_site'

          end
        end

        # sitemap
        match '/sitemap.xml'  => 'locomotive/public/sitemaps#show', :format => 'xml'

        # robots.txt
        match '/robots.txt'   => 'locomotive/public/robots#show', :format => 'txt'

        # public content entry submissions
        resources :locomotive_entry_submissions, :controller => 'locomotive/public/content_entries', :path => 'entry_submissions/:slug'

        # magic urls
        match '/_admin'               => 'locomotive/public/pages#show_toolbar'
        match ':locale/_admin'        => 'locomotive/public/pages#show_toolbar', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match ':locale/*path/_admin'  => 'locomotive/public/pages#show_toolbar', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match '*path/_admin'          => 'locomotive/public/pages#show_toolbar'

        match '/_edit'                => 'locomotive/public/pages#edit'
        match ':locale/_edit'         => 'locomotive/public/pages#edit', :page_path => 'index', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match ':locale/*path/_edit'   => 'locomotive/public/pages#edit', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match '*path/_edit'           => 'locomotive/public/pages#edit'

        root :to                      => 'locomotive/public/pages#show'
        match ':locale'               => 'locomotive/public/pages#show', :page_path => 'index', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match ':locale/*path'         => 'locomotive/public/pages#show', :locale => /(#{Locomotive.config.site_locales.join('|')})/
        match '*path'                 => 'locomotive/public/pages#show'
      end
    end
  end
end

