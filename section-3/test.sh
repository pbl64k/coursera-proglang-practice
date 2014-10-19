#!/bin/sh
cat section-3-solutions.sml section-3-tests.sml | sml | grep -i -P '(false|error)' | grep -v -P '^exception TypeError$'
