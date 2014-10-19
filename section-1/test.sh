#!/bin/sh
cat section-1-solutions.sml section-1-tests.sml | sml | grep -i -P '(false|error)'
