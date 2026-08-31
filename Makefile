.DEFAULT_GOAL := help

.PHONY: help install serve build clean docker-build docker-run docker

help:
	@echo "NCPDP Docs — Makefile targets"
	@echo ""
	@echo "  install        Install npm dependencies"
	@echo "  serve          Build then serve the book at http://localhost:4000"
	@echo "  build          Build static site to docs/_book/"
	@echo "  docker-build   Build the Docker image"
	@echo "  docker-run     Run the container on http://localhost:8080"
	@echo "  docker         Build + run the Docker container"
	@echo "  clean          Remove build output, node_modules, and container"

install:
	npm install

serve: build
	npx honkit serve docs

build:
	npx honkit build docs

docker-build:
	docker build -t ncpdp-docs .

docker-run:
	docker run -d -p 8080:80 --name ncpdp-docs ncpdp-docs

docker: docker-build docker-run

clean:
	rm -rf docs/_book node_modules
	docker rm -f ncpdp-docs 2>/dev/null || true