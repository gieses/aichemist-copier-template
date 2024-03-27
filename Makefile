# change your shell here, this is needed for smooth conda workflows.
.ONESHELL:
CONDA_ACTIVATE = source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
.DEFAULT_GOAL := help
.PHONY: help conda_prepare_base copier copier_aichemist env
ENV_NAME = "Base"

## update conda base env
conda_prepare_base:
	conda install -c conda-forge mamba conda-devenv copier -n base

## copier example
copier:
	copier copy mlr_copier_template mlr_application --data-file mlr_app_config.yml

## copier aichemist
copier_aichemist:
	copier copy copier_template aichemist --data-file example_configs/aichemist_example.yml --trust

## env
env:
	mamba env update -f environment.yml -n $(ENV_NAME)

help:
	@echo "$$(tput bold)Available rules:$$(tput sgr0)"
	@echo
	@sed -n -e "/^## / { \
		h; \
		s/.*//; \
		:doc" \
		-e "H; \
		n; \
		s/^## //; \
		t doc" \
		-e "s/:.*//; \
		G; \
		s/\\n## /---/; \
		s/\\n/ /g; \
		p; \
	}" ${MAKEFILE_LIST} \
	| LC_ALL='C' sort --ignore-case \
	| awk -F '---' \
		-v ncol=$$(tput cols) \
		-v indent=19 \
		-v col_on="$$(tput setaf 6)" \
		-v col_off="$$(tput sgr0)" \
	'{ \
		printf "%s%*s%s ", col_on, -indent, $$1, col_off; \
		n = split($$2, words, " "); \
		line_length = ncol - indent; \
		for (i = 1; i <= n; i++) { \
			line_length -= length(words[i]) + 1; \
			if (line_length <= 0) { \
				line_length = ncol - indent - length(words[i]) - 1; \
				printf "\n%*s ", -indent, " "; \
			} \
			printf "%s ", words[i]; \
		} \
		printf "\n"; \
	}' \
	| more $(shell test $(shell uname) = Darwin && echo '--no-init --raw-control-chars')
