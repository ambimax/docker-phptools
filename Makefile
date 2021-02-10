build:
	docker build -t ambimax/phptools .

local-tests:
	sh .github/scripts/local-tests.sh

docker-tests:
	sh .github/scripts/docker-tests.sh
