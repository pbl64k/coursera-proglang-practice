#!/bin/sh
cat section-2-solutions.sml section-2-tests.sml | sml | grep -i -P '(false|error)'
