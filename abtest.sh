oc new-project abtest --display-name="AB Testing" 
oc new-app --image-stream=php --code=https://github.com/VeerMuchandi/ab-deploy --name=app-a 
oc new-app --image-stream=php --code=https://github.com/VeerMuchandi/ab-deploy#v2 --name=app-b 
oc expose svc app-a --name=appab --hostname=abtest.${DOMAIN_NAME}
oc annotate route/appab haproxy.router.openshift.io/balance=roundrobin

 
