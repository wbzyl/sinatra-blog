# Sinatra Blog

## Passenger + Nginx Installation

Clone the Passenger repo::

```
git clone git://github.com/FooBarWidget/passenger.git
```

Add these files to the repo root directory:
```
ruby-2.0.0-p353   # .ruby-version
passenger         # .ruby-gemset
```

Check out the latest tagged version and compile the nginx module:

```
git checkout -b release-4.0.36

rvm current

./bin/passenger-install-nginx-module
```
Choose 1. when asked

```
1. Yes: download, compile and install Nginx for me. (recommended)
```

Replace with care the generated configuration file
*/opt/nginx/conf/nginx.conf*:

```

user  wbzyl;
worker_processes  1;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  1024;
}


http {
    passenger_root /home/wbzyl/GitHub/passenger;
    passenger_ruby /home/wbzyl/.rvm/gems/ruby-2.0.0-p353@passenger/wrappers/ruby;

    # proxy_read_timeout 60;

    include       mime.types;
    default_type  application/octet-stream;

    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;

    server {
        listen       80;
        server_name  sinatra.local;

        #charset koi8-r;

        #access_log  logs/host.access.log  main;

        location / {
            root   html;
            index  index.html index.htm;
        }

        location ~ ^/nosql(/.*|$) {
            passenger_base_uri /nosql;
            alias /home/wbzyl/repos/tutorials/nosql-tutorial/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/nosql-tutorial;
            passenger_enabled on;
        }

        location ~ ^/hcj(/.*|$) {
            passenger_base_uri /hcj;
            alias /home/wbzyl/repos/tutorials/hcj-tutorial/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/hcj-tutorial;
            passenger_enabled on;
        }

        location ~ ^/spa(/.*|$) {
            passenger_base_uri /spa;
            alias /home/wbzyl/repos/tutorials/spa-tutorial/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/spa-tutorial;
            passenger_enabled on;
        }

        location ~ ^/ti(/.*|$) {
            passenger_base_uri /spa;
            alias /home/wbzyl/repos/tutorials/techniki-internetowe/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/techniki-internetowe;
            passenger_enabled on;
        }


        location ~ ^/rails4(/.*|$) {
            passenger_base_uri /rails4;
            alias /home/wbzyl/repos/tutorials/rails4-tutorial/lib/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/rails4-tutorial/lib;
            passenger_enabled on;
        }

        location ~ ^/rails3(/.*|$) {
            passenger_base_uri /rails3;
            alias /home/wbzyl/repos/tutorials/rails3-tutorial/lib/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/rails3-tutorial/lib;
            passenger_enabled on;
        }

        location ~ ^/sp(/.*|$) {
            passenger_base_uri /sp;
            alias /home/wbzyl/repos/tutorials/sp-tutorial/lib/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/sp-tutorial/lib;
            passenger_enabled on;
        }

        location ~ ^/c(/.*|$) {
            passenger_base_uri /c;
            alias /home/wbzyl/repos/tutorials/c-exercises/lib/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/c-exercises/lib;
            passenger_enabled on;
        }

        location ~ ^/seminarium(/.*|$) {
            passenger_base_uri /seminarium;
            alias /home/wbzyl/repos/tutorials/seminarium/lib/public$1;
            passenger_app_root /home/wbzyl/repos/tutorials/seminarium/lib;
            passenger_enabled on;
        }

}
```

Modify (add) to /etc/hosts*:

```
# Do not remove the following line, or various programs
# that require network functionality will fail.
127.0.0.1	localhost.localdomain	localhost
::1	localhost6.localdomain6	localhost6
# my local blogs
127.0.0.1	sinatra.local
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
