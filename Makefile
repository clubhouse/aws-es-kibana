.PHONY: deploy

VERSION="1.0.8-pre"

deploy:
	npm install clean-dir
	npm pack
	aws s3 cp . s3://clubhouse-build-support/artifacts/aws-es-kibana-proxy/ --recursive --exclude "*" --include "*.tgz"
