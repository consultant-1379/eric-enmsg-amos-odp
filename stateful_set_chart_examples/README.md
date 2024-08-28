This folder contains example ericIngress and amos helper services definitions.

Execute in order:

X -> number of amos instance

cd amosX
first create service, then ericIngress object,

currently it contains data for enm10

kubectl apply -f amosX_service.yaml
kubectl apply -f amosX_ericIngress.yaml