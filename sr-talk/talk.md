* Packaging
* Rip
* Bundler

!SLIDE code

    |-- lib
    |   |-- foo
    |   |   |-- bar.rb
    |   |   `-- baz.rb
    |   `-- foo.rb


!SLIDE

# Mauvaises pratiques

!SLIDE

@@@ ruby
require File.dirname(__FILE__) + "/bar"
require File.dirname(__FILE__) + "/../test_helper"

unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))
  $LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__)))
end
@@@

!SLIDE

@@@ ruby
Rake::TestTask.new(:test) do |t|
  t.libs << "lib" << "test"
end
@@@

<br />

@@@ sh
testrb -Ilib -Itest test/*_test.rb
alias t='ruby -Ilib -Itest -rpp'
@@@

!SLIDE

@@@ ruby
VERSION = File.read(File.join(File.dirname(__FILE__), "..", "..", "VERSION")).strip
@@@

<br />

@@@ ruby
class Foo
  VERSION = "3.0"
end

puts Foo::VERSION # => "3.0"
@@@

!SLIDE

> The system I use to manage my $LOAD_PATH is not your library/app/tests
> concern. Whether rubygems is used or not is an environment issue. Your
> library or app should have no say in the matter. Explicitly requiring
> rubygems is either not necessary or misguided. -- **Ryan Tomayko**

!SLIDE

@@@ ruby
require "rubygems"
begin
  gem "mustache"
  require "mustache"
rescue Gem::LoadError
  abort "fail"
end
@@@

!SLIDE

`export RUBYOPT=rubygems`

!SLIDE
![Wait for it](./dvs.jpg)

_Use the $LOAD_PATH!_

!SLIDE

# Rip

* <http://github.com/defunkt/rip>
* <http://hellorip.com>
* <http://pypi.python.org/pypi/virtualenv>

!SLIDE

# Fonctionement

@@@ sh
export PATH="$RIPDIR/active/bin:$PATH"
export RUBYLIB="$RIPDIR/active/lib"
@@@

!SLIDE

@@@ sh
rip create dojo-sinatra
rip install sinatra
rip install git://github.com/brynary/rack-test
rip install http://is.gd/4l5Ha
@@@

!SLIDE

@@@ sh
rip freeze > deps.rip
rip install deps.rip
@@@

!SLIDE

* `Errno::ENOENT: No such file or directory - /home/simon/.rip/active/VERSION`
* `echo 42 > $RIPDIR/active/VERSION`

!SLIDE

@@@ sh
cat > $RIPDIR/active/rubygems.rb
def gem(*args)end
module Gem
 def self.ruby; "ruby"; end
end
@@@

!SLIDE

# Mon avis

* Pas encore production-ready
* Parfait pour le development
* `s.add_development_dependency`

!SLIDE

# Bundler

<http://github.com/wycats/bundler>

!SLIDE

* `gem --version` >= 1.3.5
* `gem install bundler`

!SLIDE

# Gemfile
@@@ ruby
source "http://gemcutter.org"
gem "dm-core", "0.10.0"
gem "dm-types", "0.10.0"
gem "dm-timestamps", "0.10.0"
gem "sinatra"

gem "thin", :only => :development

only :test do
  gem "rack-test"
  gem "contest", :git => "git://github.com/citrusbyte/contest"
end
@@@

!SLIDE

@@@ sh
$ gem bundle
Calculating dependencies...
Updating source: http://gems.rubyforge.org
Updating source: http://gemcutter.org
Cloning git repository at: git://github.com/citrusbyte/contest
Downloading dm-core-0.10.0.gem
Downloading dm-types-0.10.0.gem
[...]
Done
$ gem bundle
Done
@@@

!SLIDE

* `gem exec ruby foo.rb`
* `ruby -rvendor/gems/environment foo.rb`
* `Bundler.require_env(RAILS_ENV)`

!SLIDE

# Mon avis

* Bientot defacto: Rails, Merb, Gemcutter, ...
* A utiliser d'urgence
* System gems FTL

# Voir aussi

* http://gist.github.com/54177
* http://yehudakatz.com/2009/07/24/rubygems-good-practice/
* http://weblog.rubyonrails.org/2009/9/1/gem-packaging-best-practices

!SLIDE

# Merci. Questions?

!SLIDE

![The Legendary](./legendary.gif)
