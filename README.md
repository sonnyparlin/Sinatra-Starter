Sinatra Starter
==============

A starter template for my Sinatra projects. Uses erb, coffeescript, scaffolding_extensions, sinatra-authentication and has a basic MVC structure. To use this, you need a Sinatra development environment. There's a [great article](https://www.digitalocean.com/community/articles/how-to-install-and-get-started-with-sinatra-on-your-system-or-vps) that explains everything for you and in great detail. But to sum it up:

    \curl -L https://get.rvm.io | bash -s stable --ruby
    
    source ~/.rvm/scripts/rvm
    
    gem install sinatra

Once you have your Sinatra development environment set up:

    cd some_directory
    
    git clone git@github.com:sonnyparlin/Sinatra-Starter.git
    
    cd Sinatra-Starter
    
    bundle install
    
    rackup
