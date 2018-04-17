oc new-project health --display-name="Health Checks" 
oc new-app --image-stream=redhat-openjdk18-openshift:1.2 --code=https://github.com/veermuchandi/spring-sample-app --name=sample
oc set probe dc/sample --liveness --get-url=http://:8080/live
oc set probe dc/sample --readiness --get-url=http://:8080/ready
oc expose svc sample 

 
