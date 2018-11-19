.PHONY: deploy artifact clean ensure-clean-working-tree

REVISION=$(shell git rev-parse --verify --short HEAD)
ARTIFACT="aws-es-kibana-proxy-$(REVISION).tar.gz"
WORKING_TREE=$(strip $(shell git status --porcelain))

ensure-clean-working-tree:
ifndef WORKING_TREE
	@echo "Unclean working tree, cannot deploy."
	@exit 1
endif

clean:
	rm -rf node_modules/ *.tgz

$(ARTIFACT): clean ensure-clean-working-tree
	yarn install --pure-lockfile && \
	tar czfv $(ARTIFACT) .

artifact: $(ARTIFACT)

deploy: artifact
	aws s3 cp $(ARTIFACT) s3://clubhouse-build-support/artifacts/aws-es-proxy/$(ARTIFACT)
