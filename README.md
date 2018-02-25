## Requirement
* Unicorn 
    - You can install with ``` gem install 'unicorn' ```
* Rails application

## Usage
Download deployer file
```bash
curl -LsS https://git.io/vAgP6 -o ./deploy.rb
```

Use the command like this

    $ ruby deploy.rb --help

## Arguments:
Add your custom arguments in command line

| Argument  | Type of Parameter | Description |
| ------- | ------ | --------- |
| `--pid-file` | string | Application pid path |
| `--errors-file` | string | Server errors file path |
| `--output-file` | string | Server output file path |
| `--socket-file` | string | The class of item |
| `--workers` | integer | Number of workers |
| `--timeout` | integer | Number of timeout |
| `--env` | string | Rails application environment - default: development |

## Deploy
Deploy your rails application with unicorn to create socket file

    $ ruby deploy.rb [arguments] --start

## Config rails application on nginx
Define upstream app in nginx config file

```nginx
upstream app {
	
	server unix:/File/path/to/unicorn/socket/file.sock fail_timeout=0;

}
```

Define server 
```nignx
server {
	
	listen 3000 default;

	root /File/path/to/rails/project/public;

	try_files $uri/index.html $uri @app;

	location @app {

		proxy_pass http://app;
	}
}
```

And then restart you nginx server and enjoy your application on rails with unicorn and nginx.
