docker run \
 -it \
 -h http_serve01 \
 --rm \
 --name=my_http_serve \
 -v ~/Downloads/jboss:/serve \
 -p 8000:8000 \
 http_serve:latest
