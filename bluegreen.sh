oc new-project bluegreen --display-name="Blue Green Project" --description="Blue Green Project" 
oc new-app --image-stream=php --code=https://github.com/VeerMuchandi/bluegreen --name=blue 
oc new-app --image-stream=php --code=https://github.com/VeerMuchandi/bluegreen#green --name=green 
oc expose svc blue --name=bluegreen --hostname=bluegreen.${DOMAIN_NAME}
 
