#!/bin/bash

KUBECONFIG=${OKD_HOME}/auth/kubeconfig oc get csr | grep -i pending
