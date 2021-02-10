# Docker PHP-Tools

[![Build Status](https://github.com/ambimax/docker-phptools/workflows/.github/workflows/default.yml/badge.svg?branch=main)](https://github.com/ambimax/docker-phptools/actions)

Collection of php developer tools used for building other docker images.

### Tools:

- codebeautifier2
- codebeautifier3
- codecept
- codesniffer2
- codesniffer3
- composer
- composer2
- phpmd
- phpunit5
- phpunit6
- phpunit7
- phpunit9
- php-cs-fixer
- mhsendmail
- modman
- n98-magerun
- n98-magerun2
- zettr

### Location

All tools are save to `/tools`

### Helpers

- codesniffer
- phplint
- xmllint

## XMLLint

To ignore specific directories or files add a `.xmllint_ignore` file to your repository

```
app/code/community/Aoe_*
app/code/core/*
```

## PHPLint

To ignore specific directories or files add a `.phplint_ignore` file to your repository

```
src/app/code/community/Aoe_*
src/modman/app/code/core/*
```

## CodeSniffer

To ignore specific directories or files add a `.phpcs_ignore` file to your repository

```
app/code/community/Aoe_*
app/code/core/*
```

## License

[MIT License](http://choosealicense.com/licenses/mit/)

## Author Information

- [Tobias Schifftner](https://twitter.com/tschifftner), [ambimax® GmbH](https://www.ambimax.de)
