# -*- coding: utf-8 -*-

require 'rdiscount'
require 'erubis'
require 'coderay'

require 'sinatra/base'

class SinatraBlog < Sinatra::Base

  # configure :development do
  # end
  # configure :production do
  # end

  set :erb, :pattern => '\{% %\}', :trim => true
  set :markdown, :layout => false

  set :show_exceptions, false
  set :logging, true

  settings.static = true

  get '/' do
    erb(markdown(:main))
  end

  get '/:section' do
    erb(markdown(:"#{params[:section]}"))
  end

  not_found do
    'This is nowhere to be found.'
  end

  error do
    'Sorry there was a nasty error – ' + env['sinatra.error'].name
  end


  # TODO: prettyprint file contents located in 'doc' directory

  get %r{^([-_\w\/]+)\/([-_\w]+)\.((\w{1,4})(\.\w{1,4})?)$} do

    translate = { # to coderay syntax names
      'html.erb' => 'erb',
      'text.erb' => 'text',
      'erb' => 'erb',
      'rb' => 'ruby',
      'ru' => 'ruby',
      'js' => 'javascript',
      'yml' => 'yaml',
      'sql' => 'sql',
      'json' => 'json',
      'c' => 'c',
      'sh' => 'bash'
    }

    content_type 'text/html', :charset => 'utf-8'

    dirname = params[:captures][0]
    name = params[:captures][1]
    extname = params[:captures][2]
    filename = name + "." + extname

    # TODO: replace WB@Rails4 with something meaningful

    @title =  'WB@Rails4' + dirname.split('/').join(' » ')

    @filename = File.expand_path(File.join(File.dirname(__FILE__), 'doc', dirname, filename))

    lang = translate[extname] || 'plain_text'

    if File.exists?(@filename) && File.readable?(@filename)
      content = "<h1>#{filename}</h1>"
      content += "<pre><code>:::#{lang}\n#{escape_html(File.read @filename)}</code></pre>"
      #content += "<pre><code>:::#{lang}\n#{File.read(@filename)}</code></pre>"
    else
      content = "<h2>oops! couldn't find <em>#{filename}</em></h2>"
    end

    erb content, :layout => :code
  end

  # get "/" do
  #   "settings.root: #{settings.root}\nsettings.views: #{settings.views}"
  # end

  # get "/index" do
  #   erb :index
  # end

end
