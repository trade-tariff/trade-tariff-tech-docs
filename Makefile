.PHONY: install test start build

start: build
	NO_CONTRACTS=true bundle exec middleman server

install:
	bundle exec middleman build

test:
	bundle exec rake

build: install clean
	NO_CONTRACTS=true bundle exec middleman build

clean:
	rm -rf build; rm -rf .cache

update-tech-docs:
	bundle update govuk_tech_docs && FIRST_TIME=false bundle exec middleman init . -T alphagov/tech-docs-template
