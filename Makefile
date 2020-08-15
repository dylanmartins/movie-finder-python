run:
	@gunicorn movie_finder:app --bind localhost:8080 --worker-class aiohttp.worker.GunicornUVLoopWebWorker -e SIMPLE_SETTINGS=movie_finder.settings.development

requirements-test:
	@pip install -r requirements/test.txt

requirements-dev:
	@pip install -r requirements/dev.txt

test:
	@SIMPLE_SETTINGS=movie_finder.settings.test py.test movie_finder

test-matching:
	@SIMPLE_SETTINGS=movie_finder.settings.test pytest -rxs -k${Q} movie_finder

test-coverage:
	@SIMPLE_SETTINGS=movie_finder.settings.test pytest --cov=movie_finder movie_finder --cov-report term-missing

lint:
	@flake8
	@isort --check

detect-outdated-dependencies:
	@sh -c 'output=$$(pip list --outdated); echo "$$output"; test -z "$$output"'

release-patch: ## Create patch release
	SIMPLE_SETTINGS=movie_finder.settings.test bump2version patch --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version patch

release-minor: ## Create minor release
	SIMPLE_SETTINGS=movie_finder.settings.test bump2version minor --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version minor

release-major: ## Create major release
	SIMPLE_SETTINGS=movie_finder.settings.test bump2version major --dry-run --no-tag --no-commit --list | grep new_version= | sed -e 's/new_version=//' | xargs -n 1 towncrier --yes --version
	git commit -am 'Update CHANGELOG'
	bump2version major
