OCP_RELEASE="4.7.0-0.okd-2021-02-25-144700"
LOCAL_REGISTRY='bastion.mj1.growin.co.kr:5000'
LOCAL_REPOSITORY='openshift/okd'
PRODUCT_REPO='openshift'
RELEASE_NAME="okd"
LOCAL_SECRET_JSON='/opt/registry/pull-secret'

GODEBUG=x509ignoreCN=0 oc adm -a ${LOCAL_SECRET_JSON} release mirror \
--from=quay.io/${PRODUCT_REPO}/${RELEASE_NAME}:${OCP_RELEASE} \
--to=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY} \
--to-release-image=${LOCAL_REGISTRY}/${LOCAL_REPOSITORY}:${OCP_RELEASE}
