require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-lint'

PuppetLint.configuration.send('disable_2sp_soft_tabs')
PuppetLint.configuration.send('disable_class_inherits_from_params_class')

desc "Check puppet files for syntax errors"
task :syntax do
    Dir.chdir( 'manifests' )
    Dir.glob( '**/*.pp' ).each do |file|
        system( "puppet parser validate #{file}" )

        if !$?.success?
            fail( "${file} failed to parse" )
        end
    end
end

desc "Run all continuous integration tasks"
task :ci => [
    :syntax,
    :lint,
    :spec,
]
