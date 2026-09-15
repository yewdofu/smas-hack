PYTHON ?= python
REGION ?= jp

.PHONY: all ss nss
all: ss nss

ss:
	$(PYTHON) tools/build.py --region $(REGION) --savestates 1

nss:
	$(PYTHON) tools/build.py --region $(REGION) --savestates 0
