echo '----> remove all folders and files'

rm -rf Gemfile
rm -rf Gemfile.lock
rm -rf config.ru
rm -rf Rakefile
rm -rf README.md
rm -rf package.json

sudo rm -rf app bin config db lib log public storage test tmp vendor

echo '----> remove postgres and rails-app container'

docker-compose down
docker-compose rm -f

echo '----> build app'

docker-compose build # --no-cache

echo '----> init project'

docker-compose run web rails new . --webpack=react --force --database=mysql --skip-bundle

echo '----> change owner to thaidn'

sudo chown -R thaidn:thaidn .

echo '----> override config folder'

cp .docker/config/* config/ -vv -f

docker-compose up

# docker-compose run api bash -c 'rails db:drop && rails db:create && rails db:migrate && rails db:seed'
