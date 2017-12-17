# CTR-ESC project

This is a try out website to work with github pages in combination with heroku backend.

The repository is cloned from the HACKER github theme that is build as a jekyll web page.

In order to combine it with a Heroku backend I followed [this tutorial](https://coderwall.com/p/8lq1ba/how-to-create-a-contact-form-for-a-github-pages-served-jekyll-website).

### Frontend:

Cloning this project allows you to run it locally with bundle:
1. Run `bundle exec jekyll serve` to start the preview server
2. Visit [`localhost:4000`](http://localhost:4000) in your browser to preview the theme

You can adjust layout and style in the /assets/css/style.scss and /layouts/default.html place.

### Backend:

After creating a Heroku account (verified so you have to give a credit card). You sign up for Captcha (ensures email service is not misused) and Sendgrid (ensures an email is send with correct information by a safe way).

A small note on creating a Captcha Key, ensure you include both kkelchte.github.com domain as well as the ctr-esc-form.herokuapp.com domain.

Create your heroku backend step by step:

* make a local clone of your Heroku project after installing the heroku client.

```
$ brew install heroku/brew/heroku
$ heroku login
$ heroku git:clone -a ctr-esc-form
$ cd ctr-esc-form
```

* start from a [rackbased](https://devcenter.heroku.com/articles/rack) git project. Just like in the steps if you follow this link.

```
$ cat > config.ru
run lambda { |env| [200, {'Content-Type'=>'text/plain'}, StringIO.new("You go cowboy!\n")] }
[Ctrl-D]
$ cat > Gemfile
source 'https://rubygems.org'
gem 'rack'
[Ctrl-D]
$ touch Gemfile.lock
```

* test with bundle install

```
$ bundle install
$ bundle exec rackup -p 9292 config.ru
[CTR+C]
```

* gradually add more dependencies and see if it compiles locally and on heroku and fill in the proper CAPTCHA keys.

```
$ cat >> Gemfile
gem 'rack-recaptcha'
gem 'sinatra'
gem 'pony'
gem 'json'
[CTR+D]
$ cat > config.ru
require 'rubygems'
require 'sinatra'
require 'json'
require 'rack/recaptcha'
require 'pony'

use Rack::Recaptcha, :public_key => 'YOUR_PUBLIC_KEY', :private_key => 'YOUR_PRIVATE_KEY'
helpers Rack::Recaptcha::Helpers

run lambda { |env| [200, {'Content-Type'=>'text/plain'}, StringIO.new("You go cowboy!\n")] }
[CTR+D]
$ bundle install
$ bundle exec rackup -p 9292 config.ru
```

* adding the application

```
$ cp config.ru config.ru.t
$ sed '$ d' config.ru.t > config.ru
$ cat >> config.ru
require './application'
run Sinatra::Application
$ cat > appication.rb
before do
  content_type :json
  headers 'Access-Control-Allow-Origin' => '*',
          'Access-Control-Allow-Methods' => ['POST']
end

set :protection, false
set :public_dir, Proc.new { File.join(root, "_site") }

post '/send_email' do
  if recaptcha_valid?
    res = Pony.mail(
      :from => params[:name] + "<" + params[:email] + ">",
      :to => 'kkelchtermans@gmail.com',
      :subject => "[CTR-ESC] " + params[:subject],
      :body => params[:message],
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.sendgrid.net',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => ENV['SENDGRID_USERNAME'],
        :password             => ENV['SENDGRID_PASSWORD'],
        :authentication       => :plain,
        :domain               => 'heroku.com'
      })
    content_type :json
    if res
      { :message => 'success' }.to_json
    else
      { :message => 'failure_email' }.to_json
    end
  else
    { :message => 'failure_captcha' }.to_json
  end
end

not_found do
  File.read('_site/404.html')
end

get '/*' do
  file_name = "_site#{request.path_info}/index.html".gsub(%r{\/+},'/')
  if File.exists?(file_name)
    File.read(file_name)
  else
    raise Sinatra::NotFound
  end
end
$ git add *
$ git commit -am 'add application'
$ git push heroku master
```

* adding your form on the client or front end site

```

```


