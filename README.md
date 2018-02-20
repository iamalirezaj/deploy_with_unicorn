## Usage
Use the command like this

    $ ruby deploy.rb --help

## Arguments:
Add your custom arguments at command line

    --pid-file=file_path
    
    --errors_file=file_path
    
    --output_file=file_path
    
    --socket-file=file_path
    
    --workers=number_of_workers
    
    --timeout=30

## Deploy
Deploy your rails application with unicorn to create socket file

    $ ruby deploy.rb [arguments] --start

