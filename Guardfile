# A sample Guardfile
# More info at https://github.com/guard/guard#readme

group :specs do

  guard 'rspec', focus_on_failed: true do
    watch(%r{^spec/**/.+_spec\.rb$})
    watch(%r{^models/(.+)\.rb$})  { |m| "spec/**/#{m[1]}_spec.rb" }
    # watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
    watch('spec/spec_helper.rb')  { "spec" }
  end

  guard 'cucumber', cli: '--format pretty' do
    watch(%r{^features/.+\.feature$})
    watch(%r{^models/(.+)\.rb$})  { |m| "features/#{m[1]}.feature" }
    watch(%r{^features/support/.+$})          { 'features' }
    watch(%r{^features/step_definitions/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'features' }
  end

end

