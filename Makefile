SHELL=/bin/sh -e
CURRENT_FOLDER := "$(PWD)"
DESTINATION_FOLDER := "charts/"

# Example: make update-charts branch=main
.PHONY: update-charts
update-charts:
	make update-primaza-app-chart branch=$(branch)
	make update-fruits-app-chart branch=$(branch)

	make update-index

# Example: make update-fruits-app-chart branch=main
.PHONY: update-fruits-app-chart
update-fruits-app-chart:
	chart="fruits-app"; \
	gitRepo=https://github.com/halkyonio/atomic-fruits-service; \
	repoFolder=$(PWD)/repository/$$chart; \
	chartFolder=$$repoFolder/target/helm/kubernetes/$$chart; \
	rm -rf $$repoFolder; \
	git clone $$gitRepo $$repoFolder; \
	cd $$repoFolder; \
	git checkout $(branch); \
	mvn clean install -DskipTests -Dquarkus.profile=helm; \
	chartVersion=`grep '^version:' $$chartFolder/Chart.yaml | awk '{print $2}' | sed -e 's/-SNAPSHOT//g' | sed -e 's/version: //g'` ; \
	cd $(CURRENT_FOLDER); \
	echo Chart $$chart - $$chartVersion; \
	helm package $$chartFolder --dependency-update --version $$chartVersion -d $(DESTINATION_FOLDER) ; \
	rm -rf $$repoFolder; \

# Example: make update-primaza-app-chart branch=main
.PHONY: update-primaza-app-chart
update-primaza-app-chart:
	chart="primaza-app"; \
	gitRepo=https://github.com/halkyonio/primaza-poc; \
	repoFolder=$(PWD)/repository/$$chart; \
	chartFolder=$$repoFolder/app/target/helm/kubernetes/$$chart; \
	rm -rf $$repoFolder; \
	git clone $$gitRepo $$repoFolder; \
	cd $$repoFolder; \
	git checkout $(branch); \
	gitCommit=`git rev-parse HEAD`; \
	mvn clean install -Dgit.sha.commit=$$gitCommit -Dgithub.repo=$$gitRepo -DskipTests -Pkubernetes -Dquarkus.kubernetes.ingress.host=primaza.io; \
	chartVersion=`grep '^version:' $$chartFolder/Chart.yaml | awk '{print $2}' | sed -e 's/-SNAPSHOT//g' | sed -e 's/version: //g'` ; \
	cd $(CURRENT_FOLDER); \
	echo Chart $$chart - $$chartVersion; \
	helm package $$chartFolder --dependency-update --version $$chartVersion -d $(DESTINATION_FOLDER) ; \
	rm -rf $$repoFolder; \

.PHONY: update-index
update-index:
	cd $(DESTINATION_FOLDER)
	rm -f index-cache.yaml
	helm repo index --url https://halkyonio.github.io/helm-charts --merge index.yaml .
	cd $(CURRENT_FOLDER)