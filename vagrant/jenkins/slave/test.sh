#!/bin/bash
options='-o /dev/null -w %{http_code} -sfI'
page="http://localhost:80"
sleep 30
outstr=$(curl $options $page)
retVal=$?
[[ $retVal -eq 0 ]] || { echo "ERROR should have been able to pull $page, retVal=$retVal, code=$outstr"; exit 4; }
echo "OK pulling from $page successful, retVal=$retVal, code=$outstr"
