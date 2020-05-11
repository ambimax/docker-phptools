FROM php:7.0-cli-alpine3.7

LABEL maintainer="Tobias Schifftner <ts@ambimax.de>"

COPY scripts/phplint.sh /tools/phplint
COPY scripts/xmllint.sh /tools/xmllint
COPY scripts/codesniffer.sh /tools/codesniffer
COPY CodeSniffer /tools/CodeSniffer


# Install curl
RUN apk add --no-cache --update \
  bash \
  curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /tools \
#
# composer
&& curl -sS -L -o /tools/composer https://getcomposer.org/download/1.10.6/composer.phar \
  && echo "29bdac1bda34d8902b9f9e4f5816de08879b8f3fafad901e4283519cdefbee7b  /tools/composer" | sha256sum -c - \
# n98-magerun
&& curl -sS -o /tools/n98-magerun https://files.magerun.net/n98-magerun-1.103.3.phar \
  && echo "c6f41a21e53f9253a59eaa50fc76375a5e1e30898968cc534eb57c0d4ffdeec0  /tools/n98-magerun" | sha256sum -c - \
# mhsendmail
&& curl -sS -o /tools/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
  && echo "be5acdc8ce3f380dcb9d02caed77c845affa9a447d0860961529b699dcd0c613  /tools/mhsendmail" | sha256sum -c - \
# zettr
&& curl -sS -o /tools/zettr https://raw.githubusercontent.com/tschifftner/zettr/master/zettr.phar \
  && echo "527dcabc6b080bdaa65d253d1982ffdb7b5b337d5df3ad285b93f13ee256fc55  /tools/zettr" | sha256sum -c - \
# modman
&& curl -sS -o /tools/modman https://raw.githubusercontent.com/colinmollenhour/modman/master/modman \
  && echo "490a382be6faf4a90b516c8ac425b432817e650d840fcd8495497de33d4d4cf2  /tools/modman" | sha256sum -c - \
# phpunit5
&& curl -sS -o /tools/phpunit5 https://phar.phpunit.de/phpunit-5.7.27.phar \
  && echo "f0300a13f2653bee10b0ce24dbc8d94e65dc9be8966d822b9e455b6b294be16e  /tools/phpunit5" | sha256sum -c - \
# phpunit6
&& curl -sS -o /tools/phpunit6 https://phar.phpunit.de/phpunit-6.5.14.phar \
  && echo "3ac5d3234ed2b2dd9aaaa1b33e5c275ce5d7d8f2e07ec7fa930f5036894cc689  /tools/phpunit6" | sha256sum -c - \
# phpunit7
&& curl -sS -o /tools/phpunit7 https://phar.phpunit.de/phpunit-7.5.20.phar \
  && echo "472b6e275e4479bab71f2f7744d2e22ace9566a4e3cef37952e4d9c07f6d3a92  /tools/phpunit7" | sha256sum -c - \
# phpunit8
&& curl -sS -o /tools/phpunit8 https://phar.phpunit.de/phpunit-8.5.4.phar \
  && echo "a7c6acaa5651aa23b045b5a7714ea2341b4e83c70e92e6b42916435e2bd0c0bd  /tools/phpunit8" | sha256sum -c - \
# phpunit9
&& curl -sS -o /tools/phpunit9 https://phar.phpunit.de/phpunit-9.1.4.phar \
  && echo "87c5c7376a142f7fc00c44d8ff0b36be3bd5205d3609e05e085270f90c3909da  /tools/phpunit9" | sha256sum -c - \
# codecept
&& curl -sS -o /tools/codecept https://codeception.com/codecept.phar \
  && echo "62b084c087ac115c474ef7b1a14b62eb603181cbf58cb25103c74bd7fb825926  /tools/codecept" | sha256sum -c - \
# php mess detector
&& curl -sS -L -o /tools/phpmd https://phpmd.org/static/latest/phpmd.phar \
  && echo "0b531cbbc18a26115eede06077d5670e1f4fd0a8545d7fe547adf068fb7f18c5  /tools/phpmd" | sha256sum -c - \
# codesniffer
&& curl -sS -L -o /tools/phpcs3 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.5/phpcs.phar \
  && echo "4a2f6aff1b1f760216bb00c0b3070431131e3ed91307436bb1bfb252281a804a  /tools/phpcs3" | sha256sum -c - \
# code beautifier
&& curl -sS -L -o /tools/phpcbf3 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.5.5/phpcbf.phar \
  && echo "6f64fe00dee53fa7b256f63656dc0154f5964666fc7e535fac86d0078e7dea41  /tools/phpcbf3" | sha256sum -c - \
# codesniffer
&& curl -sS -L -o /tools/phpcs2 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.2/phpcs.phar \
  && echo "35816e79ffce37bf4d27ec398607df1663ef68f9915acdd9784b31880fbde681  /tools/phpcs2" | sha256sum -c - \
# code beautifier
&& curl -sS -L -o /tools/phpcbf2 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.2/phpcbf.phar \
  && echo "c70f472a5d5d06f8c6da0d7dca0f77bff5adef661027dcca678bec690587e930  /tools/phpcbf2" | sha256sum -c - \
# code beautifier
&& curl -sS -L -o /tools/php-cs-fixer https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.16.3/php-cs-fixer.phar \
  && echo "0b16375c2356d4a00c21c34d61953b154549670503180a622fb6adb77030b2a4  /tools/php-cs-fixer" | sha256sum -c - \
#
# set permissions
&& chmod +x /tools/*
