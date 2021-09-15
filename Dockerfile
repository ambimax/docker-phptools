FROM php:7.4-cli-alpine3.12

LABEL maintainer="Tobias Schifftner <ts@ambimax.de>"

ENV PATH="/tools:${PATH}"

COPY install.sh /usr/local/bin/addPackage
COPY scripts/phplint.sh /tools/phplint
COPY scripts/xmllint.sh /tools/xmllint
COPY scripts/codesniffer.sh /tools/codesniffer
COPY CodeSniffer /tools/CodeSniffer

# Install curl
RUN apk add --no-cache --update \
  bash \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /tools \
  && chmod +x /usr/local/bin/addPackage \
# Add wait-for-it.sh
&& addPackage \
  --url "https://raw.githubusercontent.com/vishnubob/wait-for-it/81b1373f17855a4dc21156cfe1694c31d7d1792e/wait-for-it.sh" \
  --path "/tools/wait-for-it.sh" \
  --sha256sum "b7a04f38de1e51e7455ecf63151c8c7e405bd2d45a2d4e16f6419db737a125d6" \
# Add mhsendmail
&& addPackage \
  --url "https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64" \
  --path "/tools/mhsendmail" \
  --sha256sum "be5acdc8ce3f380dcb9d02caed77c845affa9a447d0860961529b699dcd0c613" \
  # Add composer
&& addPackage \
  --url "https://getcomposer.org/download/1.10.20/composer.phar" \
  --path "/tools/composer" \
  --sha256sum "e70b1024c194e07db02275dd26ed511ce620ede45c1e237b3ef51d5f8171348d" \
# Add composer2
&& addPackage \
  --url "https://getcomposer.org/download/2.1.7/composer.phar" \
  --path "/tools/composer2" \
  --sha256sum "2936587e1babafa50d15eacf9fe775e825ed2e1f051c61acd3fa4f6af7720e94" \
# Add n98-magerun
&& addPackage \
  --url "https://files.magerun.net/n98-magerun-1.103.3.phar" \
  --path "/tools/n98-magerun" \
  --sha256sum "c6f41a21e53f9253a59eaa50fc76375a5e1e30898968cc534eb57c0d4ffdeec0" \
# Add n98-magerun2
&& addPackage \
  --url "https://files.magerun.net/n98-magerun2-4.4.0.phar" \
  --path "/tools/n98-magerun2" \
  --sha256sum "88fe7765bbf38981e951e0f93439091c93239f8500d8be9c5a77a6d8dcefbe45" \
# Add zettr
&& addPackage \
  --url "https://raw.githubusercontent.com/tschifftner/zettr/master/zettr.phar" \
  --path "/tools/zettr" \
  --sha256sum "527dcabc6b080bdaa65d253d1982ffdb7b5b337d5df3ad285b93f13ee256fc55" \
# Add modman
&& addPackage \
  --url "https://raw.githubusercontent.com/colinmollenhour/modman/1.13/modman" \
  --path "/tools/modman" \
  --sha256sum "490a382be6faf4a90b516c8ac425b432817e650d840fcd8495497de33d4d4cf2" \
# Add phpunit5
&& addPackage \
  --url "https://phar.phpunit.de/phpunit-5.7.27.phar" \
  --path "/tools/phpunit5" \
  --sha256sum "f0300a13f2653bee10b0ce24dbc8d94e65dc9be8966d822b9e455b6b294be16e" \
# Add phpunit6
&& addPackage \
  --url "https://phar.phpunit.de/phpunit-6.5.14.phar" \
  --path "/tools/phpunit6" \
  --sha256sum "3ac5d3234ed2b2dd9aaaa1b33e5c275ce5d7d8f2e07ec7fa930f5036894cc689" \
# Add phpunit7
&& addPackage \
  --url "https://phar.phpunit.de/phpunit-7.5.20.phar" \
  --path "/tools/phpunit7" \
  --sha256sum "472b6e275e4479bab71f2f7744d2e22ace9566a4e3cef37952e4d9c07f6d3a92" \
# Add phpunit8
&& addPackage \
  --url "https://phar.phpunit.de/phpunit-8.5.14.phar" \
  --path "/tools/phpunit8" \
  --sha256sum "dfc1958fe61cf7cd743e1fecc192767d91f64cab37093bafba74348c6e248ab0" \
# Add phpunit9
&& addPackage \
  --url "https://phar.phpunit.de/phpunit-9.5.2.phar" \
  --path "/tools/phpunit9" \
  --sha256sum "bcf913565bc60dfb5356cf67cbbccec1d8888dbd595b0fbb8343a5019342c67c" \
# Add codeception
&& addPackage \
  --url "https://codeception.com/releases/4.1.20210201/codecept.phar" \
  --path "/tools/codecept" \
  --sha256sum "5ead8f8f25c90e9cf5383e4c6f8d9c503f12ec924ba03a2e4aa9c483ebc154b9" \
# Add php-messdetector
&& addPackage \
  --url "https://github.com/phpmd/phpmd/releases/download/2.10.2/phpmd.phar" \
  --path "/tools/phpmd" \
  --sha256sum "5d16d2571ed029ce94a8dfcec2f50a280f9c896a1454eb93014474841861aa01" \
# Add php-codesniffer 3
&& addPackage \
  --url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.8/phpcs.phar" \
  --path "/tools/phpcs3" \
  --sha256sum "6a2ae49e677d471dbeb8a8bcf67f714611250024c15d538a543db5b7ae6df50c" \
# Add php-codebeatifier 3
&& addPackage \
  --url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.8/phpcbf.phar" \
  --path "/tools/phpcbf3" \
  --sha256sum "6079de7bb0fcafe020d5a5dc44dfe88a8ff57b253a4dfd2bfde90ebe3d189195" \
# Add php-codesniffer 2
&& addPackage \
  --url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.1/phpcs.phar" \
  --path "/tools/phpcs2" \
  --sha256sum "ad58ee2ce17dade0ceff3a5090386af63e55faf16beba15256e578064981f8f6" \
# Add php-codebeatifier 2
&& addPackage \
  --url "https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.1/phpcbf.phar" \
  --path "/tools/phpcbf2" \
  --sha256sum "a1bde49a936eb38de4b207aa73e3faa4fea82c6ca80ec9eb06b184712673b1ae" \
# Add php-cs-fixer
&& addPackage \
  --url "https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.18.2/php-cs-fixer.phar" \
  --path "/tools/php-cs-fixer" \
  --sha256sum "e39d5b7b53bfcbdda26f98593556dff220a40fe7bd0e82b8ed9ec890c9f0ba8d"
