FROM alpine

LABEL maintainer="Tobias Schifftner <ts@ambimax.de>"

# Install curl
RUN apk add --update \
  curl \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir -p /tools \
#
# n98-magerun
&& curl -sS -o /tools/n98-magerun https://files.magerun.net/n98-magerun-1.101.1.phar \
  && echo "3c48fb685e569f2c7c97cca1dfbe2d20e6d7841db594b0d706924f517d8d3fd3  /tools/n98-magerun" | sha256sum -c - \
  && chmod +x /tools/n98-magerun \
# mhsendmail
&& wget -O /tools/mhsendmail https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 \
  && echo "be5acdc8ce3f380dcb9d02caed77c845affa9a447d0860961529b699dcd0c613  /tools/mhsendmail" | sha256sum -c - \
  && chmod +x /tools/mhsendmail \
# zettr
&& curl -sS -o /tools/zettr https://raw.githubusercontent.com/tschifftner/zettr/master/zettr.phar \
  && echo "527dcabc6b080bdaa65d253d1982ffdb7b5b337d5df3ad285b93f13ee256fc55  /tools/zettr" | sha256sum -c - \
  && chmod +x /tools/zettr \
# modman
&& curl -sS -o /tools/modman https://raw.githubusercontent.com/colinmollenhour/modman/master/modman \
  && echo "6db573ade6802408fa7a509d8fa045b7cdf57d703e89d0b93e457dc2466b5176  /tools/modman" | sha256sum -c - \
  && chmod +x /tools/modman \
# phpunit5
&& curl -sS -o /tools/phpunit5 https://phar.phpunit.de/phpunit-5.7.27.phar \
  && echo "f0300a13f2653bee10b0ce24dbc8d94e65dc9be8966d822b9e455b6b294be16e  /tools/phpunit5" | sha256sum -c - \
  && chmod +x /tools/phpunit5 \
# phpunit6
&& curl -sS -o /tools/phpunit6 https://phar.phpunit.de/phpunit-6.5.12.phar \
  && echo "3c20bd232b6cd9925af5600f12a2c2bddb8004cde58029ecb566c7886997210c  /tools/phpunit6" | sha256sum -c - \
  && chmod +x /tools/phpunit6 \
# phpunit7
&& curl -sS -o /tools/phpunit7 https://phar.phpunit.de/phpunit-7.3.2.phar \
  && echo "9a2d8582f149b6c800487c907bebc93b3dd2f2871e16f9b9c26c618081778440  /tools/phpunit7" | sha256sum -c - \
  && chmod +x /tools/phpunit7 \
# codecept
&& curl -sS -o /tools/codecept https://codeception.com/codecept.phar \
  && echo "e41ba47e3576e72b8bd806e11d438a6155198f183cf7efd459e5e575faf8be36  /tools/codecept" | sha256sum -c - \
  && chmod +x /tools/codecept \
# php mess detector
&& curl -sS -L -o /tools/phpmd https://static.phpmd.org/php/latest/phpmd.phar \
  && echo "69bec1176370a3bcbb81e1d422253f70305432ecf5b2c50d04ec33adb0e20f7a  /tools/phpmd" | sha256sum -c - \
  && chmod +x /tools/phpmd \
# codesniffer
&& curl -sS -L -o /tools/phpcs3 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.3.1/phpcs.phar \
  && echo "5ce1bc0dfead797a02efdb0b01f99fc4b5bb4ef42757286e648b2364b273814f  /tools/phpcs3" | sha256sum -c - \
  && chmod +x /tools/phpcs3 \
# code beautifier
&& curl -sS -L -o /tools/phpcbf3 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/3.3.1/phpcbf.phar \
  && echo "353ec2717ae043917308de7c0dae4805356129c6df9638e0f7daaf4c3c82e560  /tools/phpcbf3" | sha256sum -c - \
  && chmod +x /tools/phpcbf3 \
# codesniffer
&& curl -sS -L -o /tools/phpcs2 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.1/phpcs.phar \
  && echo "ad58ee2ce17dade0ceff3a5090386af63e55faf16beba15256e578064981f8f6  /tools/phpcs2" | sha256sum -c - \
  && chmod +x /tools/phpcs2 \
# code beautifier
&& curl -sS -L -o /tools/phpcbf2 https://github.com/squizlabs/PHP_CodeSniffer/releases/download/2.9.1/phpcbf.phar \
  && echo "a1bde49a936eb38de4b207aa73e3faa4fea82c6ca80ec9eb06b184712673b1ae  /tools/phpcbf2" | sha256sum -c - \
  && chmod +x /tools/phpcbf2

COPY --from=composer:latest /usr/bin/composer /tools/composer