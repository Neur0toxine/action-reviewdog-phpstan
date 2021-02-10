#!/bin/sh
set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
    cd "${GITHUB_WORKSPACE}" || exit
fi

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

php /usr/local/bin/phpstan.phar analyse ${INPUT_TARGET_DIRECTORY} --no-progress --error-format=raw ${INPUT_ARGS} | \
    uniq -u | \
    reviewdog -name=PHPStan -f=phpstan -reporter=${INPUT_REPORTER} -level=${INPUT_LEVEL} -diff='git diff'
