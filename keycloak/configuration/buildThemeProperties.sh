#!/usr/bin/env bash
set -ex

echo 'hi'

case $SPACE in \
"int") \
    cp ./configuration/theme.properties.int ./govuk-theme/govuk/account/theme.properties &&\
    cp ./configuration/theme.properties.int ./govuk-theme/govuk/login/theme.properties;; \
"staging") \
    cp ./configuration/theme.properties.staging ./govuk-theme/govuk/account/theme.properties &&\
    cp ./configuration/theme.properties.staging ./govuk-theme/govuk/login/theme.properties;; \
"prod") \
    cp ./configuration/theme.properties.prod ./govuk-theme/govuk/account/theme.properties &&\
    cp ./configuration/theme.properties.prod ./govuk-theme/govuk/login/theme.properties;; \
*);;\
esac
