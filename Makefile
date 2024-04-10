.PHONY: install test start build

start: build
	NO_CONTRACTS=true bundle exec middleman server

test: check
	bundle exec rake

build: clean check
	NO_CONTRACTS=true bundle exec middleman build

check:
	bundle check || bundle install

clean:
	rm -rf build; rm -rf .cache

update-tech-docs:
	bundle update govuk_tech_docs && FIRST_TIME=false bundle exec middleman init . -T alphagov/tech-docs-template
