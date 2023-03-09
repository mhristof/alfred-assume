MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.ONESHELL:

.DEFAULT_GOAL := zip

zip: assume.alfredworkflow

assume.alfredworkflow: 12052AE8-4778-4489-A7BE-EC17C1ED54DD.png icon.png info.plist
	zip -r assume.alfredworkflow $?

.PHONY: install
install: assume.alfredworkflow
	open assume.alfredworkflow

.PHONY: release
release:
	sed -i "s/$(shell semver current | tr -d 'v')/$(shell semver -n | head -1 | rev | awk '{print $$1}' | rev | tr -d 'v')/g" info.plist
	git add info.plist
	git commit -m 'ci: bumped version'
	semver

.PHONY: help
help:  ## Show this help
	@grep '.*:.*##' Makefile | grep -v grep  | sort | sed 's/:.* ##/:/g' | column -t -s:

