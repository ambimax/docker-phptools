build:
	docker build -t ambimax/phptools .

push:
	docker push ambimax/phptools

local-tests:
	sh .github/scripts/local-tests.sh

docker-tests:
	sh .github/scripts/docker-tests.sh

run:
	docker run --rm -it ambimax/phptools bash