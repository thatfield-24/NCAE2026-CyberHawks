# Again thank you to Team Hawaii. https://github.com/Alphabaddie420xx/UHWO-NCAE-RESOURCES/blob/main/Webserver%20Configuration
# Verify base app configuration is correct ------------------------------------------------------------------------
# Verryy basic flask app config looks like this:

from flask import Flask
app = Flask(__name__)
@app.route("/")
def index():
  return "this is the front page"
app.run(host="127.0.0.1", port=5000) <- this is just an example, but pay attention to this field during competition

# Verify systemd unit is not modified by red team -----------------------------------------------------------------
# should be named this: etechacademy 

# probably is this:
sudo nano /etc/systemd/system/etechacademy.service

sudo systemctl daemon-reload
sudo systemctl start etechacademy
sudo systemctl enable etechacademy
 
# Configure nginx as reverse proxy --------------------------------------------------------------------------------
sudo nano /etc/nginx/sites-available/etechacademy.conf <- if there is already a file for it, then we would use that instead of this

Configure it like this:
server {
    listen 192.168.10.5:80;
    server_name www.team10.ncaecybergames.org;

    location / {
        include proxy_params;
        proxy_pass http://localhost:5000;
    }
}


# This is similar to what will be added after we run the certbot command :3 so go on to the next section
#server {
#    listen 192.168.10.5:443 ssl;
#    server_name www.team10.ncaecybergames.org;
#
#    ssl_certificate /etc/letsencrypt/live/example.com/fullchain.pem;
#    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
#
#    location / {
#        include proxy_params;
#        proxy_pass http://127.0.0.1:5000; #<- change this according to where the flask app is running :3
#        # proxy_set_header Host $host;
#        # proxy_set_header X-Real-IP $remote_addr;
#        # ^ instead of these can just include proxy_params, which we put on the top
#  }
#}

# Create a symlink from sites-available to sites-enabled ---------------------------------------------------------
sudo ln -s /etc/nginx/sites-available/etechacademy.conf /etc/nginx/sites-enabled/

# check if the file is valid:
sudo nginx -t

# start nginx and enable it
systemctl enable nginx
systemctl start nginx

# while here, check out the other enabled sites and make sure nothing else is up

# Try certbot ----------------------------------------------------------------------------------------------------
certbot --nginx --server https://ca.ncaecybergames.org/acme/acme/directory --no-random-sleep-on-renew

# Now remove http from the configuration and keep the new https configuration that certbot put in

# Configure security settings on nginx ----------------------------------------------------------------------------
  - /etc/nginx/sites-enabled/etechacademy.conf ---- paste this in the server { listen blah:443 ssl;} field above the "location" line

      # Use only TLS 1.3
      ssl_protocols TLSv1.3;
    
      # Modern TLS 1.3 ciphers
      ssl_ciphers TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256;

      # Recommended settings
      ssl_prefer_server_ciphers on;
      ssl_session_cache shared:SSL:10m;

      # Strong security headers (optional) --- not sure abt this one, might not add this in
      add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload" always;

      # blocks potentially dangerous or unused methods like TRACE, DELETE, etc. --- put this in the first "location" blockf 
      limit_except GET POST HEAD {
        deny all;
      }

      # Deny access to dotfiles -- put this above the first "location" line
      location ~ /\.(?!well-known).* {
        deny all;
      }

  # reload nginx after
  sudo nginx -t
  sudo systemctl reload nginx
- /etc/nginx/nginx.conf
      # hides version in headers
      server_tokens off; 
      # Prevent clickjacking
      add_header X-Frame-Options "SAMEORIGIN" always;
      
      # Prevent XSS in older browsers
      add_header X-XSS-Protection "1; mode=block" always;
      
      # Prevent MIME-sniffing
      add_header X-Content-Type-Options "nosniff" always;
