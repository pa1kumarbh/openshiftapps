oc new-project cicd --display-name="CICD Project" 
oc new-project development --display-name="Development Project"
oc new-project testing --display-name="QA Project"

oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-group system:image-puller system:serviceaccounts:testing -n development

oc new-app jenkins-ephemeral -n cicd


oc new-app --image-stream=php --code=https://github.com/VeerMuchandi/ab-deploy --name=myapp -n development
oc set triggers bc/myapp --manual -n development
oc set triggers dc/myapp --manual -n development
oc expose svc myapp -n development

oc new-app $DOCKER_REGISTRY_URL/development/myapp:promoteToQA --name=myapp --allow-missing-images -n testing 
oc set triggers dc/myapp --manual -n testing     

sleep 300
oc new-build --code=https://github.com/VeerMuchandi/pipeline-example --name=myapp-pipeline -n cicd --strategy=pipeline
