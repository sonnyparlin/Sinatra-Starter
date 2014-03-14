Sinatra Starter
==============

A starter template for my Sinatra projects. Uses erb, coffeescript, scaffolding_extensions, sinatra-authentication and has a basic MVC structure. To use this, you need a Sinatra development environment. There's a [great article](https://www.digitalocean.com/community/articles/how-to-install-and-get-started-with-sinatra-on-your-system-or-vps) that explains everything for you and in great detail. But to sum it up, get to your terminal and type the following:

### Install RVM (Ruby version manager)
    
    \curl -L https://get.rvm.io | bash -s stable --ruby
    
    source ~/.rvm/scripts/rvm
    
### Install Sinatra
    
    gem install sinatra

### Install this Sinatra starter app
Once you have your Sinatra development environment set up:

    cd some_directory
    
    git clone git@github.com:sonnyparlin/Sinatra-Starter.git
    
    cd Sinatra-Starter
    
    bundle install
    
    rackup

### Usage
Browse to http://localhost:9292, you'll see a front end about Frank Sinatra. Next, browse to http://localhost:9292/admin (admin/12345) to log in and view your admin panel. Fire up your favorite text editor and start making changes. 
