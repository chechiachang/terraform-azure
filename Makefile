TF_FILES = $(shell find . -not -path '*/\.terragrunt-cache/*' -type f -name "*.tf" -exec dirname {} \;|sort -u)

default: fmt

.PHONY: fmt
fmt:
	@for m in $(TF_FILES); do (terraform fmt -diff "$$m" && echo "√ $$m"); done
