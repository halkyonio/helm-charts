SHELL=/bin/sh -e
CURRENT_FOLDER := "$(PWD)"
DESTINATION_FOLDER := "charts/"

# Example: make update-charts branch=main
.PHONY: update-charts
update-charts:
	chart="primaza-app"; \
	repoFolder=$(PWD)/repository/$$chart; \
	rm -rf $$repoFolder; \
	git clone https://github.com/halkyonio/primaza-poc $$repoFolder; \
	cd $$repoFolder; \
	git checkout $(branch); \
	mvn clean install -DskipTests -Pkubernetes; \
	chartFolder=$$repoFolder/app/target/helm/kubernetes/$$chart; \
	cd $(CURRENT_FOLDER); \
	echo Chart $$chart ; \
	helm package $$chartFolder --dependency-update -d $(DESTINATION_FOLDER) ; \
	rm -rf $$repoFolder; \

	make update-index

.PHONY: update-index
update-index:
	cd $(DESTINATION_FOLDER)
	rm -f index-cache.yaml
	helm repo index --url https://halkyonio.github.io/primaza-helm --merge index.yaml .
	cd $(CURRENT_FOLDER)